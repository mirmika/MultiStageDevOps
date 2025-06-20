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
