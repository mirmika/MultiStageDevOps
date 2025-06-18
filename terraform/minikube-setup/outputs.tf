output "namespace_names" {
  value = [for ns in kubernetes_namespace.envs : ns.metadata[0].name]
}

output "mongo_secret_namespaces" {
  value = [for s in kubernetes_secret_v1.mongo_url : s.metadata[0].namespace]
}