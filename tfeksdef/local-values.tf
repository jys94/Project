# Define Local Values in Terraform
locals {
  owners = var.business_divsion
  environment = var.environment
  seoul_prefix = "${var.brand_prefix}_${var.region_name[var.aws_region]}"
  name = "${var.business_divsion}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
  eks_cluster_name = "${local.name}-eks-${var.region_name[var.aws_region]}-1"
  node_groups = {
    web        = "nodegroup-web",
    was        = "nodegroup-was",
    cicd       = "nodegroup-cicd",
    monitoring = "nodegroup-monitoring",
    logging    = "nodegroup-logging"
  }
  ngs = { for ng in var.provision-ngs: ng => local.node_groups[ng]}
}