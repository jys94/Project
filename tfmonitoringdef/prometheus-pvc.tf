# Resource: Persistent Volume Claim
resource "kubernetes_persistent_volume_claim_v1" "efs_pvc_prometheus" {
  metadata {
    name = "prometheus-server-pvc"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    storage_class_name = kubernetes_storage_class_v1.efs_sc_prometheus.metadata[0].name
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}