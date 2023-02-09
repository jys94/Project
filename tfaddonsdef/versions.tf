terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.50"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.8"
    }
    http = {
      source = "hashicorp/http"
      version = "~> 3.2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.16"
    }
    null = { # Using - VPA
      source = "hashicorp/null"
      version = "~> 3.2"
    }
  }

  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "lish-prj-terraform-backend"
    key    = "dev/eks-addons/terraform.tfstate"
    region = "ap-northeast-2"
    # For State Locking
    dynamodb_table = "dev-eks-addons"
  }     
}