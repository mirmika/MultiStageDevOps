# MultiService App – Kubernetes Dev Deployment

This project is a microservices-based application deployed to Kubernetes using **Helm**, **Minikube**, **Ingress**, and **MongoDB**.

---

## What's Included?

- `client` – React frontend  
- `post` – Handles post creation  
- `comments` – Handles comments (MongoDB)  
- `query` – Combines posts and comments  
- `moderation` – Approves/rejects comments  
- `event-bus` – Publishes and distributes events  
- `ingress` – NGINX routing for all services

---

## Prerequisites

- Docker  
- Minikube  
- kubectl  
- Helm

---

## 1. Start Minikube

```bash
minikube start --memory=4096 --cpus=2
minikube addons enable ingress
```

---

## 2. Add Hosts

Add this to your `/etc/hosts` (or Windows `C:\Windows\System32\drivers\etc\hosts`):

```
127.0.0.1 dev.local
127.0.0.1 stg.local
127.0.0.1 prod.local
```

---

## 3. Build and Push Docker Images

```bash
export DOCKER_BUILDKIT=0

for SERVICE in client post comments query moderation event-bus; do
  docker build --no-cache -t mirmika/$SERVICE:dev-latest ./services/$SERVICE
  docker push mirmika/$SERVICE:dev-latest
  minikube image load mirmika/$SERVICE:dev-latest
done
```

---

## 4. Install MongoDB

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install mongo bitnami/mongodb \
  --set auth.enabled=false \
  --set architecture=standalone \
  -n development --create-namespace
```

Create the MongoDB secret:

```bash
kubectl create secret generic mongo-url-secret \
  --from-literal=MONGO_URL="mongodb://mongo-mongodb:27017/comments" \
  -n development
```

---

## 5. Deploy All Services

```bash
chmod +x ./scripts/deploy-dev.sh
./scripts/deploy-dev.sh
```

This uses Helm to deploy all services into the `development` namespace.

---

## 🌐 Access the App

Forward ingress controller:

```bash
kubectl -n ingress-nginx port-forward svc/ingress-nginx-controller 8080:80
```

Then open in browser:

```
http://dev.local:8080
```

---

## Example API Tests

Create a post:

```bash
curl -X POST http://dev.local:8080/post/create \
  -H "Content-Type: application/json" \
  -d '{"title":"Hello"}'
```

Get all posts:

```bash
curl http://dev.local:8080/posts
```

Add a comment:

```bash
curl -X POST http://dev.local:8080/posts/<POST_ID>/comments \
  -H "Content-Type: application/json" \
  -d '{"content":"Nice post!"}'
```

---

## Cleanup

```bash
chmod +x ./scripts/cleanup-dev.sh
./scripts/cleanup-dev.sh
```

---

## Folder Structure

```
charts/             # Helm charts for each service
environments/dev/   # Helm values for dev
environments/stg/   # Helm values for staging
environments/prod/  # Helm values for production
scripts/            # Shell scripts for deployment
services/           # Microservice source code
```

---

## 🚥 Environments

Each environment has:

- its own Helm values under `environments/<env>/`
- its own deploy/cleanup script:
  - `deploy-dev.sh`, `deploy-stg.sh`, `deploy-prod.sh`
  - `cleanup-dev.sh`, `cleanup-stg.sh`, `cleanup-prod.sh`
```
