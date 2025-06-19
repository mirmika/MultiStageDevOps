resource "helm_release" "kuma" {
  name       = "kuma"
  repository = "https://kumahq.github.io/charts"
  chart      = "kuma"
  namespace  = "kuma-system"

  create_namespace = true

  values = [yamlencode({
    controlPlane = {
      enabled = true
      mode    = "standalone"
    }

    metrics = {
      enabled = true
      prometheus = {
        enabled = true
      }
      grafana = {
        enabled = true
      }
    }

    zoneIngress = {
      enabled = false
    }

    ingress = {
      enabled = false
    }

    tracing = {
      enabled = false
    }

    global = {
      kumaDataplane = {
        resources = {
          limits = {
            cpu    = "100m"
            memory = "128Mi"
          }
        }
      }
    }
  })]
}
