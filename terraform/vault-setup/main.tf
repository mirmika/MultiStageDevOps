terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.28"
    }
  }
}

provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "minikube"
}

resource "vault_kv_secret_v2" "mongo_url" {
  mount = "secret"
  name  = "mongo-url"
  data_json = jsonencode({
    development = "mongodb://mongo:27017/comments"
    staging     = "mongodb://mongo:27017/comments"
    production  = "mongodb://mongo:27017/comments"
  })
}

resource "kubernetes_namespace" "env_namespace" {
  metadata {
    name = var.environment
  }
}

resource "kubernetes_secret" "mongo_url" {
  metadata {
    name      = "mongo-url-secret"
    namespace = kubernetes_namespace.env_namespace.metadata[0].name
  }
  
  data = {
    MONGO_URL = vault_kv_secret_v2.mongo_url.data[var.environment]
  }
}
