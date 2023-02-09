# Security Group for EKS Node Group - Placeholder file
data "aws_security_group" "cluster-sg" {
  filter {
    name = "group-name"
    values = [ "eks-cluster-sg-${local.eks_cluster_name}-*" ]
  }
  depends_on = [ aws_eks_cluster.eks_cluster ]
}

resource "aws_security_group" "ng-remote-access" {
  name        = "ng-remote-access"
  description = "Security group for all nodes in the cluster"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  tags = {
    "Name" = "ng-remote-access"
  }
}