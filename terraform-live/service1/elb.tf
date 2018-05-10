module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "1.2.0"

  name = "stage-app1-elb"

  subnets         = ["${module.vpc.public_subnets}"]
  security_groups = ["${module.security-group-elb.this_security_group_id}"]
  internal        = false


  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
  ]

  health_check = [
    {
      target              = "HTTP:80/"
      interval            = 30
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
    },
  ]

  tags = {
    Owner       = "arlindo santos"
    Environment = "stage"
  }
}

