data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

######
# Launch configuration and autoscaling group
######

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "2.3.0"

  name = "${var.environment}-${var.app}-webserver"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" 
  # Use the existing launch configuration
  # create_lc = false 
  # disables creation of launch configuration
 
  lc_name = "${var.environment}-${var.app}-lc"

  image_id                    = "${data.aws_ami.amazon_linux.id}"
  key_name                    = "ansible"
  instance_type               = "t2.micro"
  user_data                   = <<-EOF
				#!/bin/bash
				yum install -y nginx 
				service nginx start
				EOF
  security_groups             = ["${module.security-group-app.this_security_group_id}"]
  associate_public_ip_address = false
  load_balancers = ["${module.elb.this_elb_id}"]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "20"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size           = "20"
      volume_type           = "gp2"
      delete_on_termination = true
    },
  ]

  # Auto scaling group
  asg_name                  = "${var.environment}-${var.app}-asg"
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
      value               = "arlindo"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}
