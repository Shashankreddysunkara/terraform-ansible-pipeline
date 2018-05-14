module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.30.0"

  name = "vpc-stage"

  cidr = "10.10.0.0/16"

  azs                 = ["ca-central-1a", "ca-central-1b"]
  private_subnets     = ["10.10.3.0/24", "10.10.4.0/24"]
  public_subnets      = ["10.10.13.0/24", "10.10.14.0/24"]

  create_database_subnet_group = false

  enable_nat_gateway 		= true
  enable_vpn_gateway 		= false

  enable_s3_endpoint 		= true
  enable_dynamodb_endpoint 	= true

  enable_dhcp_options 		= false

  tags = {
    Owner       = "arlindo santos"
    Environment = "stage"
  }
}
