output "namespace_names" {
  value = [for ns in kubernetes_namespace.envs : ns.metadata[0].name]
}

output "service_account_namespaces" {
  value = [for sa in kubernetes_service_account.comments_sa : sa.metadata[0].namespace]
}

output "vault_policy_name" {
  value = vault_policy.mongo_policy.name
}

output "vault_role_name" {
  value = vault_kubernetes_auth_backend_role.mongo_role.role_name
}
