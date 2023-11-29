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



/* resource "aws_security_group" "chok_sg_lb" {
  name        = "chok-sg-lb-wordpress"
  description = "SG for Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} */

/* resource "aws_security_group" "chok_sg_eks" {
  name        = "chok-sg-eks"
  description = "SG for EKS"
  vpc_id      = var.vpc_id

  # Autoriser le trafic HTTP entrant
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Autoriser le trafic HTTPS entrant
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Autoriser le trafic sortant vers Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Autoriser le trafic entrant sur le port de la base de données (ex: MariaDB/MySQL)
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.chok_sg_rds.id] # Assurez-vous que c'est le bon ID de groupe de sécurité pour RDS
  }

  # Autoriser le trafic entrant pour le contrôle et la gestion du cluster EKS
  ingress {
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.chok_sg_eks_nodes.id] # Assurez-vous que c'est le bon ID de groupe de sécurité pour les nœuds EKS
  }
} */

/* 
resource "aws_security_group" "chok_sg_eks_nodes" {
  name        = "chok-sg-eks-nodes-wordpress"
  description = "SG for EKS nodes"
  vpc_id      = var.vpc_id

  # Autorise le trafic HTTP entrant depuis le Load Balancer
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.chok_sg_lb.id]
  }

  # Autorise le trafic HTTPS entrant depuis le Load Balancer
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.chok_sg_lb.id]
  }

  # Autorise le trafic NodePort (si utilisé)
  ingress {
    from_port       = 30000
    to_port         = 32767
    protocol        = "tcp"
    security_groups = [aws_security_group.chok_sg_lb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} */


