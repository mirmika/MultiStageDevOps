resource "kubernetes_namespace" "kuma_monitoring" {
  metadata {
    name = "kuma-monitoring"
  }
}

resource "kubernetes_persistent_volume_claim" "kuma_pvc" {
  metadata {
    name      = "kuma-pvc"
    namespace = kubernetes_namespace.kuma_monitoring.metadata[0].name
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "kuma_uptime" {
  metadata {
    name      = "kuma-uptime"
    namespace = kubernetes_namespace.kuma_monitoring.metadata[0].name
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "kuma-uptime"
      }
    }
    template {
      metadata {
        labels = {
          app = "kuma-uptime"
        }
      }
      spec {
        container {
          name  = "uptime-kuma"
          image = "louislam/uptime-kuma:latest"

          port {
            container_port = 3001
          }

          volume_mount {
            name       = "kuma-data"
            mount_path = "/app/data"
          }
        }

        volume {
          name = "kuma-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.kuma_pvc.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "kuma_uptime_service" {
  metadata {
    name      = "kuma-uptime-service"
    namespace = kubernetes_namespace.kuma_monitoring.metadata[0].name
  }

  spec {
    selector = {
      app = "kuma-uptime"
    }
    type = "NodePort"
    port {
      port        = 3001
      target_port = 3001
      node_port   = 31300
    }
  }
}
