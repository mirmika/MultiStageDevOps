provider "kubernetes" {
  config_path    = "/home/devops/.kube/config"
  config_context = "minikube"
}

provider "helm" {
  kubernetes = {
    config_path    = "/home/devops/.kube/config"
    config_context = "minikube"
  }
}