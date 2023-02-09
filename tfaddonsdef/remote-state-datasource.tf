data "terraform_remote_state" "backend_info" {
  backend = "local"
  config = {
    path = "${path.module}/../terraform.tfstate"
  }
}
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "${data.terraform_remote_state.backend_info.outputs.bucket_id}"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = var.aws_region
  }
}