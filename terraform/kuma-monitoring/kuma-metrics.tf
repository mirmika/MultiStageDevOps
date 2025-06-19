resource "null_resource" "kuma_observability" {
  provisioner "local-exec" {
    command = "kumactl install observability | kubectl apply -f -"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kumactl install observability | kubectl delete -f -"
  }
}
