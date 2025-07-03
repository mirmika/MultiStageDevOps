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

```bash
minikube start
```

### 2. CI/CD Pipeline Execution

Pipelines are triggered on:

- develop branch (development)
- main branch (staging)
- Tags (`v*`) for production

Pipelines automate:

- Infrastructure provisioning (Terraform)
- MongoDB deployment (Helm)
- Application deployment (Helm)
- Kuma monitoring setup
- Secure secrets with Vault setup

### 3. Local Kubernetes Ingress Setup (WSL)

When running Kubernetes locally via **Windows Subsystem for Linux (WSL)**, follow these steps to configure ingress hostnames (`local.dev`, `local.stg`, `local.pro`) for seamless access:

1. **Retrieve your current WSL IP address:**

   ```bash
   WSL_IP=$(hostname -I | awk '{print $1}')
   echo "Your WSL IP: $WSL_IP"
   ```

2. **Update your Windows hosts file:**

   Open PowerShell as Administrator and add these entries (replace `<WSL_IP>` with your actual WSL IP):

   ```powershell
   Add-Content -Path "C:\Windows\System32\drivers\etc\hosts" -Value "`n<WSL_IP>`tlocal.dev"
   Add-Content -Path "C:\Windows\System32\drivers\etc\hosts" -Value "`n<WSL_IP>`tlocal.stg"
   Add-Content -Path "C:\Windows\System32\drivers\etc\hosts" -Value "`n<WSL_IP>`tlocal.pro"
   ```

   Alternatively, manually edit your Windows `hosts` file:

   ```
   C:\Windows\System32\drivers\etc\hosts
   ```

3. **Access Kubernetes services via browser:**

   - Development: [http://local.dev:9080](http://local.dev:7080)
   - Staging: [http://local.stg:9080](http://local.stg:7080)
   - Production: [http://local.pro:9080](http://local.pro:7080)

### 4. Access Services

Forward ports to access services and Kuma dashboards locally:

```bash
cd scripts
./port-forward.sh
```

Then, open the provided local URLs in your browser.

### 5. Uptime Kuma Deployment Details

- **Image:** Uses the latest `louislam/uptime-kuma` container image.
- **Platform:** Kubernetes (Minikube)
- **Configuration:** No custom environment variables set.

### 6. Cleanup

Use provided scripts to remove resources and stop Minikube:

```bash
cd scripts
./cleanup-dev.sh
./cleanup-stg.sh
./cleanup-prod.sh
minikube stop
```

## Notes

- The current backend code does not support persistent databases.
- A sample MongoDB secret (connection string) is included in Vault to demonstrate secure secret management.
- To use MongoDB (or any persistent DB), refactor backend code accordingly.

## Important:
  After port-forwarding Uptime Kuma, you will need to manually create your own username and password for the initial login.
  Once logged in, you can add monitoring dashboards and specify which services to monitor by entering URLs such as local.dev, local.stg, or local.pro, depending on the environment you want to observe.
  Make sure these local hostnames are added to your system’s hosts file to ensure correct resolution and seamless monitoring.


## Additional Information

- Kubernetes manifests (`k8s/manifests/`) are for local testing.
- Terraform and Helm actions are fully automated via CI/CD.
- Port-forwarding scripts require manual execution.
