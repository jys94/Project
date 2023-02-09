# Resource: Kubernetes Storage Class
resource "kubernetes_storage_class_v1" "efs_sc_alertmanager" {
  metadata {
    name = "efs-sc-alertmanager"
  }
  storage_provisioner = "efs.csi.aws.com"
  parameters = {
    provisioningMode = "efs-ap"
    fileSystemId = data.terraform_remote_state.addons.outputs.efs_file_system_id
    directoryPerms = "700" # optional
    gidRangeStart = "1000" # optional
    gidRangeEnd = "2000" # optional
    basePath = "/prometheus/alertmanager" # optional
    uid = "1000" # Important!
    gid = "1000" # Important!
  }
}