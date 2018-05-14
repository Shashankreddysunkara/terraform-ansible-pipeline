 
module "security-group-ssh" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "1.22.0"

  name        = "stage-app1-ssh-SG"
  vpc_id      = "${module.vpc.vpc_id}"

  tags = {
    Owner       = "arlindo santos"
    Environment = "stage"
  }

  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
         { 
       rule = "ssh-tcp"
       cidr_blocks = "0.0.0.0/0"
     },
       ]
  egress_rules = ["all-all"]
}

 
module "security-group-mysql" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "1.22.0"

  name        = "stage-app1-mysql-SG"
  vpc_id      = "${module.vpc.vpc_id}"

  tags = {
    Owner       = "arlindo santos"
    Environment = "stage"
  }

  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
         { 
       rule = "mysql-tcp"
       cidr_blocks = "0.0.0.0/0"
     },
       ]
  egress_rules = ["all-all"]
}

 
module "security-group-elb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "1.22.0"

  name        = "stage-app1-elb-SG"
  vpc_id      = "${module.vpc.vpc_id}"

  tags = {
    Owner       = "arlindo santos"
    Environment = "stage"
  }

  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
         { 
       rule = "http-80-tcp"
       cidr_blocks = "0.0.0.0/0"
     },
       ]
  egress_rules = ["all-all"]
}

 
module "security-group-app" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "1.22.0"

  name        = "stage-app1-app-SG"
  vpc_id      = "${module.vpc.vpc_id}"

  tags = {
    Owner       = "arlindo santos"
    Environment = "stage"
  }

  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
         { 
       rule = "http-80-tcp"
       cidr_blocks = "0.0.0.0/0"
     },
       ]
  egress_rules = ["all-all"]
}

