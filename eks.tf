resource "aws_eks_cluster" "chok_eks_cluster_auto" {
  name     = var.eks_cluster_name
  role_arn = "arn:aws:iam::019050461780:role/eks-iam-role"

  vpc_config {
    subnet_ids = var.public_subnet_ids
  }

  version = var.eks_cluster_version
}

resource "aws_eks_node_group" "chok_node_group_auto" {
  cluster_name    = aws_eks_cluster.chok_eks_cluster_auto.name
  node_group_name = "chok_node_group_auto"
  node_role_arn   = "arn:aws:iam::019050461780:role/eksworkernodes-iam-role"
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = 4
    max_size     = 6
    min_size     = 2
  }

  instance_types = ["t3.small"]
  disk_size      = 30
}
