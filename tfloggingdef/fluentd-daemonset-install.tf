resource "helm_release" "fluentd" {
  depends_on = [kubectl_manifest.fluentd_forwarder_configmap, helm_release.elasticsearch]
  name       = "fluentd"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "fluentd"
  version    = "5.5.14"
  
  set {
    name  = "forwarder.configMap"
    value = "fluentd-forwarder-cm"
  }
}