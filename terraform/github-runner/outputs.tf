# outputs.tf
output "runner_namespace" {
  value = kubernetes_namespace.runner_namespace.metadata[0].name
}

output "runner_deployment_name" {
  value = kubernetes_deployment.github_runner.metadata[0].name
}

output "runner_token_expiration" {
  value = data.github_actions_registration_token.runner_token.expires_at
}