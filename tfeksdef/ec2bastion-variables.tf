##### AWS EC2 Instance Terraform Variables #####

# AWS EC2 Instance Type
variable "instance_type" {
  type = string
  default = "t3.small"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  type = string
  default = "Instance-Access-Key"
}