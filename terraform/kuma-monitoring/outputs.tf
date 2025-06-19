output "kuma_uptime_dashboard_url" {
  value = "http://${data.external.minikube_ip.result.ip}:31300"
}

data "external" "minikube_ip" {
  program = ["bash", "-c", "echo '{\"ip\":\"'$(minikube ip)'\"}'"]
}
