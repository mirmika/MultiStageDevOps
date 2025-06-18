# main.tf
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

resource "kubernetes_namespace" "runner_namespace" {
  metadata {
    name = var.namespace
  }
}

data "github_actions_registration_token" "runner_token" {
  repository = var.github_repository
}

resource "kubernetes_deployment" "github_runner" {
  metadata {
    name      = "github-runner"
    namespace = kubernetes_namespace.runner_namespace.metadata[0].name
    labels = {
      app = "github-runner"
    }
  }

  spec {
    replicas = var.runner_replicas

    selector {
      match_labels = {
        app = "github-runner"
      }
    }

    template {
      metadata {
        labels = {
          app = "github-runner"
        }
      }

      spec {
        container {
          name  = "runner"
          image = var.runner_image

          env {
            name  = "RUNNER_NAME"
            value = "github-runner-01"
          }

          env {
            name  = "RUNNER_TOKEN"
            value = data.github_actions_registration_token.runner_token.token
          }

          env {
            name  = "RUNNER_REPO"
            value = "${var.github_owner}/${var.github_repository}"
          }

          env {
            name  = "RUNNER_REPOSITORY_URL"
            value = "https://github.com/${var.github_owner}/${var.github_repository}"
          }

          env {
            name  = "RUNNER_LABELS"
            value = var.runner_labels
          }

          resources {
            limits   = var.runner_resources_limits
            requests = var.runner_resources_requests
          }

          volume_mount {
            name       = "runner-volume"
            mount_path = "/runner"
          }
        }

        volume {
          name = "runner-volume"
          empty_dir {}
        }
      }
    }
  }
}