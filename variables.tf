# Ce fichier variables.tf définit plusieurs variables pour une infrastructure AWS dans Terraform. 
# Les variables incluent la région AWS (region), les identifiants des sous-réseaux publics et privés (public_subnet_ids, private_subnet_ids), 
# le nom et la version du cluster EKS (eks_cluster_name, eks_cluster_version), le mot de passe de la base de données RDS (db_password) et l'identifiant du VPC (vpc_id).

variable "region" {
  description = "La région AWS pour déployer les ressources."
  type        = string
  default     = "eu-west-1"
}

variable "public_subnet_ids" {
  description = "Identifiants des subnets publics."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Identifiants des subnets privés."
  type        = list(string)
}

variable "eks_cluster_name" {
  description = "Nom du cluster EKS."
  type        = string
}

variable "eks_cluster_version" {
  description = "Version Kubernetes du cluster EKS."
  type        = string
  default     = "1.28"
}
variable "db_password" {
  description = "Password for the RDS database"
  type        = string
}

variable "vpc_id" {
  description = "Identifiant du VPC."
  type        = string
}

