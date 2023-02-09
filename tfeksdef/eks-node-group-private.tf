# Create AWS EKS Node Group - Private
resource "aws_eks_node_group" "eks_ng_private" {
  for_each        = local.ngs
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = each.value
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.vpc.private_subnets
  version         = var.cluster_version  
  ami_type        = "AL2_x86_64"  
  capacity_type   = each.key == "cicd" ? "SPOT" : "ON_DEMAND"
  instance_types  = ["t3.large"]

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 4
  }
  update_config { max_unavailable = 1 }

  launch_template {
    name = each.value
    version = data.aws_launch_template.launch_template_ref[each.key].default_version
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  ]
  tags = {
    Name = each.value
    
    # Cluster Autoscaler Tags
    "k8s.io/cluster-autoscaler/${local.eks_cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled" = "TRUE"
  }
}