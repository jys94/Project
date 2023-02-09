resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"

  set {
    name = "persistence.enabled"
    value = "true"
  }
  set {
    name = "persistence.existingClaim"
    value = "${kubernetes_persistent_volume_claim_v1.efs_pvc_grafana.metadata[0].name}" # "grafana-pvc"
  }
  set {
    name  = "nodeSelector.eks\\.amazonaws\\.com/nodegroup"
    value = "nodegroup-monitoring"
  }
  set {
    name  = "service.type"
    value = "NodePort"
  }
  set {
    name  = "service.port"
    value = "80"
  }
  set {
    name  = "securityContext.runAsUser"
    value = "1000"
  }
  set {
    name  = "securityContext.runAsGroup"
    value = "1000"
  }
  set {
    name  = "adminPassword"
    value = "admin"
  }
}