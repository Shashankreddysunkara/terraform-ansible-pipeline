terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-up-and-running-state.arlindo.ca"
    key = "awsaccount1/service2/ca-central-1/stage/terraform.tfstate"
    region = "us-east-1"
    profile = "ansiblepersonal"
    dynamodb_table = "terraform-locks"
  }
}
