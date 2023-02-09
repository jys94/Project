resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "15.15.0"

  set {
    name = "pushgateway.enabled"
    value = "false"
  }
  set {  # Default: "alertmanager.enabled: true"
    name = "alertmanager.enabled"
    value = "true"
  }
  set {
    name = "alertmanager.persistentVolume.existingClaim"
    value = "${kubernetes_persistent_volume_claim_v1.efs_pvc_alertmanager.metadata[0].name}" # "prometheus-alertmanager-pvc"
  }
  set {
    name  = "alertmanager.nodeSelector.eks\\.amazonaws\\.com/nodegroup"
    value = "nodegroup-monitoring"
  }
  set {
    name  = "alertmanager.configMapOverrideName"
    value = "notifier-config"
  }
  set {
    name  = "alertmanager.securityContext.runAsGroup"
    value = "1000"
  }
  set {
    name  = "alertmanager.securityContext.runAsUser"
    value = "1000"
  }
  set {
    name  = "alertmanager.service.type"
    value = "NodePort"
  }
  set {
    name  = "alertmanager.service.servicePort"
    value = "80"
  }
  set {
    name  = "alertmanager.baseURL"
    value = "https://promalert.${data.terraform_remote_state.addons.outputs.aws_route53_zone_name}" # value = "https://promalert.lishprj.link"
  }
  set {
    name  = "server.persistentVolume.existingClaim"
    value = "${kubernetes_persistent_volume_claim_v1.efs_pvc_prometheus.metadata[0].name}" # "prometheus-server-pvc"
  }
  set {
    name  = "server.nodeSelector.eks\\.amazonaws\\.com/nodegroup"
    value = "nodegroup-monitoring"
  }
  set {
    name  = "server.securityContext.runAsGroup"
    value = "1000"
  }
  set {
    name  = "server.securityContext.runAsUser"
    value = "1000"
  }
  set {
    name  = "server.service.type"
    value = "NodePort"
  }
  set {
    name  = "server.service.servicePort"
    value = "80"
  }
  set {
    name  = "server.extraFlags[0]"
    value = "storage.tsdb.no-lockfile"
  }
  values = ["${file("${path.module}/values.yaml")}"]
}