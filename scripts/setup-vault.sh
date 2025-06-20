#!/bin/bash
set -euo pipefail

# Check for environment parameter
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

ENVIRONMENT="$1"

# Set variables based on environment
NAMESPACE="$ENVIRONMENT"
VAULT_NS="vault"
VAULT_RELEASE="vault"
SERVICE_ACCOUNT="comments-sa"
POLICY_NAME="${ENVIRONMENT}-vault-policy"
ROLE_NAME="${ENVIRONMENT}-vault-role"
SECRET_PATH="secret/${ENVIRONMENT}/mongo-url"
MONGO_URL="mongodb://mongo:27017/comments"
HELM_VERSION="0.30.0"

# Add HashiCorp Helm repo
helm repo add hashicorp https://helm.releases.hashicorp.com || true
helm repo update

# Install or upgrade Vault with injector enabled
helm upgrade --install "$VAULT_RELEASE" hashicorp/vault \
  --version "$HELM_VERSION" \
  --namespace "$VAULT_NS" --create-namespace \
  --set "server.dev.enabled=true" \
  --set "injector.enabled=true"

# Wait for Vault pod readiness
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=vault -n "$VAULT_NS" --timeout=180s

VAULT_POD=$(kubectl get pods -n "$VAULT_NS" -l app.kubernetes.io/name=vault -o jsonpath='{.items[0].metadata.name}')

# Enable Kubernetes auth (clean setup)
kubectl exec "$VAULT_POD" -n "$VAULT_NS" -- vault auth disable kubernetes || true
kubectl exec "$VAULT_POD" -n "$VAULT_NS" -- vault auth enable kubernetes

# Retrieve fresh JWT and CA from injector SA
SA_JWT=$(kubectl exec -n "$VAULT_NS" deploy/vault-agent-injector -- cat /var/run/secrets/kubernetes.io/serviceaccount/token)
SA_CA=$(kubectl exec -n "$VAULT_NS" deploy/vault-agent-injector -- cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt)
K8S_HOST="https://kubernetes.default.svc:443"

# Configure Kubernetes auth in Vault explicitly
kubectl exec "$VAULT_POD" -n "$VAULT_NS" -- vault write auth/kubernetes/config \
  token_reviewer_jwt="$SA_JWT" \
  kubernetes_host="$K8S_HOST" \
  kubernetes_ca_cert="$SA_CA"

# Create Vault policy for KV v2 secret explicitly
cat <<EOF > /tmp/mongo-policy.hcl
path "secret/data/${ENVIRONMENT}/mongo-url" {
  capabilities = ["read"]
}
EOF
kubectl cp /tmp/mongo-policy.hcl "$VAULT_NS/$VAULT_POD":/tmp/mongo-policy.hcl
kubectl exec "$VAULT_POD" -n "$VAULT_NS" -- vault policy write "$POLICY_NAME" /tmp/mongo-policy.hcl

# Create Vault role for ServiceAccount
kubectl exec "$VAULT_POD" -n "$VAULT_NS" -- vault write auth/kubernetes/role/"$ROLE_NAME" \
  bound_service_account_names="$SERVICE_ACCOUNT" \
  bound_service_account_namespaces="$NAMESPACE" \
  policies="$POLICY_NAME" \
  ttl=24h

# Write MongoDB URL secret to Vault (KV v2 correct path)
kubectl exec "$VAULT_POD" -n "$VAULT_NS" -- \
  vault kv put "$SECRET_PATH" MONGO_URL="$MONGO_URL"

# Confirmation
kubectl exec "$VAULT_POD" -n "$VAULT_NS" -- vault kv get "$SECRET_PATH"


# Create necessary RBAC permissions for Vault injector (tokenreviews)
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: vault-tokenreviewer
rules:
- apiGroups: ["authentication.k8s.io"]
  resources: ["tokenreviews"]
  verbs: ["create"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: vault-tokenreviewer-binding
subjects:
- kind: ServiceAccount
  name: vault-agent-injector
  namespace: ${VAULT_NS}
roleRef:
  kind: ClusterRole
  name: vault-tokenreviewer
  apiGroup: rbac.authorization.k8s.io
EOF


echo "✅ Vault fully configured correctly for Kubernetes agent-injected secrets in namespace: $NAMESPACE"
