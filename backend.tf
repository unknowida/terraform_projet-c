/**
 * Configuration du backend pour le stockage de l'état Terraform.
 * Utilise le service S3 d'AWS pour stocker l'état.
 * Le bucket S3 utilisé est "chok-terraform-state-bucket".
 * La clé de l'état est définie comme "state".
 * La région utilisée est "eu-west-1".
 */
terraform {
  backend "s3" {
    bucket = "chok-terraform-state-bucket"
    key    = "state"
    region = "eu-west-1"
  }
}
