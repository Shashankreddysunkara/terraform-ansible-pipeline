provider "aws" {
  region = "us-east-1"
  profile = "default"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-up-and-running-state.arlindo.ca"
    key = "global/aws-vpc-networking/non-prod/terraform.tfstate"
    region = "us-east-1"
    profile = "default"
    dynamodb_table = "terraform-locks"
  }
}
