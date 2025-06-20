output "namespace_names" {
  value = [for ns in kubernetes_namespace.envs : ns.metadata[0].name]
}
