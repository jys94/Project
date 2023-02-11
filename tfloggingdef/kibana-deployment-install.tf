resource "helm_release" "kibana" {
  depends_on = [helm_release.elasticsearch]
  name       = "kibana"
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  # namespace = "kube-system"

  set {
    name  = "service.type"
    value = "NodePort"
  }
  set {
    name  = "secret.password"
    value = "elastic"
  }
}