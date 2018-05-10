provider "aws" {
  region = "us-east-1"
  profile = "ansiblepersonal"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-up-and-running-state.arlindo.ca"
    key = "app1/stage/terraform.tfstate"
    region = "us-east-1"
    profile = "ansiblepersonal"
    dynamodb_table = "terraform-locks"
  }
}
