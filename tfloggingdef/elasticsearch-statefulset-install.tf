resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  version    = "7.6.0"

  # set {
  #   name  = "volumeClaimTemplate.accessModes[0]"
  #   value = "ReadWriteMany"
  # }
  # set {
  #   name  = "volumeClaimTemplate.resources.requests.storage"
  #   value = "10Gi"
  # }
  # set {
  #   name  = "volumeClaimTemplate.storageClassName"
  #   value = "${kubernetes_storage_class_v1.efs_sc_elasticsearch.metadata[0].name}"
  # }
  # set {
  #   name  = "secret.password"
  #   value = "elastic"
  # }
  set {
    name  = "replicas"
    value = "2"
  }  
}