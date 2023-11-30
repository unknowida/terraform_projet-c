# Ce code Terraform crée un groupe de sous-réseaux RDS et une instance RDS dans AWS. 
# Le groupe de sous-réseaux chok-wordpress-db-subnet-group comprend les sous-réseaux privés spécifiés dans var.private_subnet_ids. 
# L'instance RDS rds-mariadb utilise le stockage gp2, exécute MariaDB version 10.5 sur une instance db.t3.micro, et a une base de données wordpressdb. 
# L'instance est configurée pour la haute disponibilité, conserve les sauvegardes pendant 7 jours, 
# n'est pas accessible publiquement, et utilise le groupe de sécurité chok_sg_rds.

# Fichier: rds.tf
resource "aws_db_subnet_group" "chok_wordpress_db_subnet_group" { # Création d'un groupe de sous-réseaux pour RDS
  name       = "chok-wordpress-db-subnet-group"
  subnet_ids = var.private_subnet_ids

}

resource "aws_db_instance" "chok_wordpress_rds" { # Création d'une instance RDS
  identifier              = "rds-mariadb"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mariadb"
  engine_version          = "10.5"
  instance_class          = "db.t3.micro"
  db_name                 = "wordpressdb"                                           # Nom de la base de données
  db_subnet_group_name    = aws_db_subnet_group.chok_wordpress_db_subnet_group.name # Utilisation du groupe de sous-réseaux pour RDS
  username                = "wpuser"                                                # Nom d'utilisateur pour la base de données
  password                = var.db_password
  parameter_group_name    = "default.mariadb10.5"
  multi_az                = true                                # Activer la haute disponibilité
  backup_retention_period = 7                                   # Nombre de jours de conservation des sauvegardes (7 est une valeur courante)
  max_allocated_storage   = 50                                  # Capacité maximale de stockage en GiB
  skip_final_snapshot     = true                                # Ne pas créer de snapshot lors de la suppression de l'instance
  publicly_accessible     = false                               # Ne pas rendre l'instance accessible publiquement
  vpc_security_group_ids  = [aws_security_group.chok_sg_rds.id] # Utiliser le SG pour RDS
  ca_cert_identifier      = "rds-ca-2019"                       # CA expiration Date August 22, 2024, 19:08 (UTC+02:00)
}
