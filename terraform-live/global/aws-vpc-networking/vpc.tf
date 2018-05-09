module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.30.0"

  name = "vpc-non-prod"

  cidr = "10.10.0.0/16"

  azs                 = ["us-east-1a", "us-east-1b"]
  private_subnets     = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets      = ["10.10.11.0/24", "10.10.12.0/24"]

  create_database_subnet_group = false

  enable_nat_gateway 		= true
  enable_vpn_gateway 		= false

  enable_s3_endpoint 		= true
  enable_dynamodb_endpoint 	= true

  enable_dhcp_options 		= false

  tags = {
    Owner       = "arlindo santos"
    Environment = "non-prod"
  }
}
