terraform {
  backend "s3" {
    bucket = "chok-terraform-state-bucket"
    key    = "state"
    region = "eu-west-1"
  }
}
