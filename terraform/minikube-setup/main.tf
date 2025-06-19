provider "kubernetes" {
  config_path = "/home/devops/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_namespace" "envs" {
  for_each = var.environments
  metadata {
    name = each.key
  }
}

resource "kubernetes_secret_v1" "mongo_url" {
  for_each = var.environments

  metadata {
    name      = "mongo-url-secret"
    namespace = each.key
  }

  data = {
    MONGO_URL = base64encode(var.mongo_url)
  }

  type = "Opaque"
}
