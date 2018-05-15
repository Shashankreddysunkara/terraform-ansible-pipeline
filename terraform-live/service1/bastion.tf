module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "1.5.0"

  name                        = "stage-app1-bastion"
  ami                         = "${data.aws_ami.amazon_linux.id}"
  key_name                    = "ansible"
  instance_type               = "t2.micro"
  subnet_id                   = "${element(module.vpc.public_subnets,0)}"
  vpc_security_group_ids      = ["${module.security-group-ssh.this_security_group_id}"]
  associate_public_ip_address = "True"
}
