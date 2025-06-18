#!/bin/bash

set -e

export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

echo "🔁 Rebuilding, pushing, and loading images into Minikube..."

# List of microservices
SERVICES=("posts" "comments" "event-bus" "moderation" "query" "client")

for SERVICE in "${SERVICES[@]}"; do
  IMAGE_NAME="mirmika/$SERVICE:dev-latest"

  echo "🔨 Building image for $SERVICE..."
  docker build --no-cache -t $IMAGE_NAME ./services/$SERVICE

  echo "🚀 Pushing $SERVICE image to Docker Hub..."
  docker push $IMAGE_NAME

  echo "📦 Loading $SERVICE image into Minikube..."
  minikube image load $IMAGE_NAME
done

echo "🔄 Restarting deployments in 'development' namespace..."

for SERVICE in "${SERVICES[@]}"; do
  if kubectl get deployment "$SERVICE" -n development &>/dev/null; then
    echo "🔃 Restarting deployment for $SERVICE..."
    kubectl rollout restart deployment "$SERVICE" -n development
  else
    echo "⚠️ Deployment for $SERVICE not found. Skipping restart."
  fi
done

echo "✅ All services rebuilt, pushed, loaded, and restarted successfully!"
