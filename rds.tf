resource "aws_db_subnet_group" "aurora-tagdemo-subnet" {
  name        = "aurora-tagdemo-subnet"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.tag-demo-private-1.id, aws_subnet.tag-demo-private-2.id]
}

resource "aws_rds_cluster_parameter_group" "aurora-tagdemo-parameters" {
  name        = "aurora-tagdemo-parameters"
  family      = "aurora-mysql5.7"
  description = "Aurora MySQL parameter group"

# AWS recommends using default values for DB parameters. If workload
# requires running parameters different than defaults, the parameters
# can be modified in the section below.

  parameter {
    name  = "max_allowed_packet"
    value = "4194304"
  }
}

resource "aws_rds_cluster" "aurora-tagdemo" {
  engine                  = "aurora-mysql"
  cluster_identifier      = "aurora-tagdemo"
  database_name           = "auroraTagDemoDB"
  master_username         = "root"           # Database username
  master_password         = var.RDS_PASSWORD # Database password
  db_subnet_group_name    = aws_db_subnet_group.aurora-tagdemo-subnet.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora-tagdemo-parameters.name
  vpc_security_group_ids  = [aws_security_group.allow-aurora-mysql.id]
  backup_retention_period = 7
  skip_final_snapshot     = true # No snapshot taken upon 'terraform destroy'
  availability_zones      = [aws_subnet.tag-demo-private-1.availability_zone, aws_subnet.tag-demo-private-2.availability_zone]
  tags = {
    Name = "aurora-tagdemo-instance"
    map-migrated = ""
  }
}

resource "aws_rds_cluster_instance" "aurora-tagdemo_instances" {
  engine             = "aurora-mysql"
  count              = 2
  identifier         = "aurora-tagdemo-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora-tagdemo.id
  instance_class     = "db.t2.small"
}
