#!/bin/bash

set -e

VAULT_NAMESPACE="vault"
HELM_RELEASE="vault"

echo "[Vault Cleanup] Uninstalling Vault Helm release..."
helm uninstall $HELM_RELEASE -n $VAULT_NAMESPACE || echo "Helm release not found, continuing."

echo "[Vault Cleanup] Deleting Vault namespace (removes all resources, pods, secrets, PVCs)..."
kubectl delete namespace $VAULT_NAMESPACE --wait || echo "Namespace not found, continuing."

echo "[Vault Cleanup] Deleting Vault CRDs (if any were installed)..."
kubectl get crd | grep 'vault' | awk '{print $1}' | xargs -r kubectl delete crd

echo "[Vault Cleanup] Deleting cluster roles and bindings related to Vault (if present)..."
kubectl delete clusterrole,clusterrolebinding -l app.kubernetes.io/name=vault --ignore-not-found

echo "[Vault Cleanup] Removing Vault Helm repo (optional)..."
helm repo remove hashicorp || true

echo "Vault cleanup completed."
