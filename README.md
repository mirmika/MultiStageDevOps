# MultiStageDevOps

A comprehensive, production-like microservices architecture leveraging Kubernetes (Minikube), Helm, Terraform, Docker, GitHub Actions Runner, Kuma Monitoring, and fully automated CI/CD pipelines.

This project demonstrates end-to-end automation of microservice deployments across multiple environments (dev, staging, prod), including infrastructure provisioning, application orchestration, and automated service uptime monitoring.

## Project Overview

- **Containerized Microservices:**
  - client (frontend)
  - comments
  - event-bus (message broker)
  - moderation
  - posts
  - query
- **CI/CD Automation:** Local GitHub Actions Runner on Minikube orchestrates build, test, and deployment pipelines.
- **Infrastructure as Code:** Terraform scripts automate all infrastructure provisioning.
- **Kubernetes Orchestration:** Microservices are deployed as Docker containers to Minikube clusters via Helm charts.
- **Automated Monitoring:** Kuma monitors service availability and uptime across all environments. Monitors are configured via CI/CD scripts.

## Quick Start

### Prerequisites

- Minikube
- kubectl
- Helm 3
- Docker
- Terraform
- GitHub Actions Runner (local)

### 1. Start Minikube

minikube start

### 2. CI/CD Pipeline Execution

Pipelines are triggered on:
- develop branch (development)
- main branch (staging)
- Tags (v*) for production

Pipelines automate:
- Infrastructure provisioning (Terraform)
- MongoDB deployment (Helm)
- Application deployment (Helm)
- Kuma monitoring setup

### 3. Access Services

Forward necessary ports to access services and Kuma dashboards locally:

cd scripts
./port-forward-dev.sh
./port-forward-stg.sh
./port-forward-prod.sh
./port-forward-kuma.sh
...
...

Then, open the provided local URLs in your browser.

### 4. Uptime Kuma Deployment Details

- **Image:** Uses the latest `louislam/uptime-kuma` container image.
- **Platform:** Deployed on Kubernetes (Minikube).
- **Configuration:** No custom environment variables set (e.g., API enablement flags).
- **Network Access:**
    - Internal container port: 3001
    - Exposed externally via Kubernetes NodePort: 3005
    - Or, for direct port-forwarding:

      kubectl port-forward svc/<kuma-service-name> -n <kuma-namespace> 3005:3001 --address='0.0.0.0'

### 5. Cleanup

Use the provided scripts to remove resources and stop Minikube:

cd scripts
./cleanup-dev.sh
./cleanup-stg.sh
./cleanup-prod.sh
minikube stop

## Note
The current backend code does not support persistent databases.
However, a sample MongoDB secret (connection string) is included in Vault as an example of how to manage secrets securely.

If you wish to use MongoDB (or any persistent DB), the backend code must first be refactored to use it.

## Additional Notes

- All Kubernetes manifests (`k8s/manifests/`) are for local testing.
- Terraform and Helm actions are automated via CI/CD; port-forwarding scripts require manual execution.
