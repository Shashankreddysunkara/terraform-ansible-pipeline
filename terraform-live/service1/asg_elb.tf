######
# Launch configuration and autoscaling group
######

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "2.3.0"

  name = "stage-app1-webserver"

  lc_name = "stage-app1-lc"

  image_id                    = "${data.aws_ami.amazon_linux.id}"
  key_name                    = "ansible"
  instance_type               = "t2.micro"
  user_data                   = <<-EOF
				#!/bin/bash
				yum install -y nginx 
				service nginx start
				EOF
  security_groups             = ["${module.security-group-app.this_security_group_id}"]
  associate_public_ip_address = "False"
  load_balancers = ["${module.elb.this_elb_id}"]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = "True"
    },
  ]

  root_block_device = [
    {
      volume_size           = "20"
      volume_type           = "gp2"
      delete_on_termination = "True"
    },
  ]

  # Auto scaling group
  asg_name                  = "stage-app1-asg"
  vpc_zone_identifier       = ["${module.vpc.private_subnets}"]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "stage"
      propagate_at_launch = true
    },
    {
      key                 = "owner"
      value               = "arlindo santos"
      propagate_at_launch = true
    },
  ]
}
