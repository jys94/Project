# LBC Helm Release Outputs
output "lbc_helm_metadata" {
  value = helm_release.loadbalancer_controller.metadata
}