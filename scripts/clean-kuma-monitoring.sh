#!/bin/bash
set -euo pipefail

NAMESPACE="kuma-monitoring"

if kubectl get namespace "$NAMESPACE"; then
  echo "Namespace '$NAMESPACE' exists. Cleaning..."
  kubectl delete namespace "$NAMESPACE"
  kubectl wait --for=delete namespace "$NAMESPACE" --timeout=120s
else
  echo "Namespace '$NAMESPACE' does not exist. No cleanup needed."
fi

echo "✅ Namespace cleanup complete."
