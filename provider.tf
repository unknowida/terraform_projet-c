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
