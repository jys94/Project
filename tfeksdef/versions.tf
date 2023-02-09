# Terraform Block
terraform {
  # Terraform Version
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # AWS Provider Version
      version = "~> 4.50"
    }
  }

  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "lish-prj-terraform-backend"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "ap-northeast-2"

    # For State Locking
    dynamodb_table = "dev-eks-cluster"
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}