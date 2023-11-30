# Ce code Terraform récupère des informations sur un cluster EKS existant et un groupe de sécurité, puis crée un nouveau groupe de sécurité pour une instance RDS. 
# Les informations sur le cluster EKS sont récupérées en fonction de var.eks_cluster_name. 
# Les informations sur le groupe de sécurité existant sont récupérées dans le VPC spécifié par var.vpc_id. 
# Un nouveau groupe de sécurité chok-sg-rds-wordpress est créé dans le même VPC. 
# Ce groupe de sécurité permet le trafic TCP sur le port 3306 à partir du groupe de sécurité du cluster EKS, et permet tout le trafic sortant vers n'importe quelle adresse IP.

data "aws_eks_cluster" "chok_cluster" {
  name = var.eks_cluster_name
}

data "aws_security_group" "eks_cluster_sg" {
  vpc_id = var.vpc_id

  filter {
    name   = "group-name"
    values = ["*eks-cluster-sg-${data.aws_eks_cluster.chok_cluster.name}*"]
  }
}

resource "aws_security_group" "chok_sg_rds" {
  name        = "chok-sg-rds-wordpress"
  description = "SG for RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [data.aws_security_group.eks_cluster_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}
