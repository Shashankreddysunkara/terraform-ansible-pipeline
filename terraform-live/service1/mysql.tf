module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "1.15.0"

  identifier = "stage-app1-mysql-dbinstance1"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.large"
  allocated_storage = 5
  storage_encrypted = "False"

  name     = "stage_app1_mysql_dbinstance1"
  username = "dbuser1"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "3306"

  vpc_security_group_ids = ["${module.security-group-mysql.this_security_group_id}"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

  tags = {
    Owner       = "arlindo santos"
    Environment = "stage"
  }

  # DB subnet group
  subnet_ids = ["${module.vpc.private_subnets}"] 
  # DB parameter group
  family = "mysql5.7"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "stage-app1-mysql-dbinstance1"
}
