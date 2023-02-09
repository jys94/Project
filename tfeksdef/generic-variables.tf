# AWS Region
variable "aws_region" {
  type = string
  default = "ap-northeast-2"
}

# AWS Region Names
variable "region_name" {
  type = map(string)
  default = {
    ap-northeast-2 = "seoul",
  }
}

# Brand Prefix
variable "brand_prefix" {
  type = string
  default = "lish_prj"
}

# Environment Variable
variable "environment" {
  type = string
  default = "infra"
}

# Business Division
variable "business_divsion" {
  type = string
  default = "web"
}