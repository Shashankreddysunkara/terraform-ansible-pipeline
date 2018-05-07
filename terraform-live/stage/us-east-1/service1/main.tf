provider "aws" {
  region = "us-east-1"
  profile = "default"
  shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-up-and-running-state.arlindo.ca"
    key = "stage/us-east-1/service1/terraform.tfstate"
    region = "us-east-1"
    profile = "default"
    dynamodb_table = "terraform-locks"
  }
}
