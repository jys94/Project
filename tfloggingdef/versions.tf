terraform {
  required_version = ">= 1.0.0"
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.8"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.16"
    }
    http = {
      source = "hashicorp/http"
      version = "~> 3.2"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }     
  }
  # S3 Backend for Remote State Storage
  backend "s3" {
    bucket = "lish-prj-terraform-backend"
    key    = "dev/eks-logging/terraform.tfstate"
    region = "ap-northeast-2"
    # State Locking
    dynamodb_table = "dev-eks-logging"
  }
}