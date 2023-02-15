resource "helm_release" "kibana" {
  depends_on = [helm_release.elasticsearch]
  name       = "kibana"
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  version    = "8.5.1"

  set {
    name  = "service.type"
    value = "NodePort"
  }
  set {
    name  = "secret.password"
    value = "elastic"
  }
}