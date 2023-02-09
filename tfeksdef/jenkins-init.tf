provider "cloudinit" { }

data "cloudinit_config" "cloudinit-jenkins" {
  gzip          = false
  base64_encode = true
  
  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/jenkins-prepare.sh", { RELEASE = var.cluster_version })
  }
}