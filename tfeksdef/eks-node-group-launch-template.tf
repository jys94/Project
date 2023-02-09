# Create AWS EKS Node Group Templates
resource "aws_launch_template" "ng_launch_template" {
  for_each = local.ngs
  name = each.value
  ebs_optimized = true
  key_name = var.instance_keypair
  user_data = each.key == "cicd" ? data.cloudinit_config.cloudinit-jenkins.rendered : null
  
  vpc_security_group_ids = [
    aws_security_group.ng-remote-access.id,
    data.aws_security_group.cluster-sg.id
  ]

  tag_specifications {
    resource_type = "instance"
    
    tags = {
      Name = each.value
    }
  }
}

# template version reference to nodegroup's launch_template
data "aws_launch_template" "launch_template_ref" {
  for_each = local.ngs
  name = each.value

  depends_on = [
    aws_launch_template.ng_launch_template
  ]
}