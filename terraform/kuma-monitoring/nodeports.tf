resource "null_resource" "nodeports_dev" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../../monitoring/dev-nodeports.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete -f ../../monitoring/dev-nodeports.yaml"
  }
}

resource "null_resource" "nodeports_staging" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../../monitoring/stg-nodeports.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete -f ../../monitoring/stg-nodeports.yaml"
  }
}

resource "null_resource" "nodeports_prod" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../../monitoring/prod-nodeports.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete -f ../../monitoring/prod-nodeports.yaml"
  }
}
