provider "aws" {
  region = "us-east-1"
  profile = "default"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-up-and-running-state.arlindo.ca"
    key = "app1/stage/terraform.tfstate"
    region = "us-east-1"
    profile = "default"
    dynamodb_table = "terraform-locks"
  }
}
