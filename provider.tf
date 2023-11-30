# Ce code Terraform définit un fournisseur AWS pour la région eu-west-1. 
# Toutes les ressources créées par ce code seront situées dans cette région. 
# Le bloc default_tags spécifie un ensemble de balises qui seront automatiquement appliquées à toutes les ressources créées par ce fournisseur. 
# Ces balises sont utiles pour l'organisation et le suivi des coûts.

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      owner    = "csafi@thenuumfactory.fr"
      ephemere = "non"
      entity   = "numfactory"
    }
  }
}
