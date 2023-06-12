provider "aws" {
  region = "us-west-2"  # Replace with your desired AWS region
}

resource "aws_db_instance" "dbgroup" {
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  identifier           = "database-1"
  username             = "admin"
  password             = "Irving75062"
  publicly_accessible = false

  tags = {
    Name = "my-rds-instance"
  }
}

data "aws_instance" "existing_instance" {
  instance_id = "i-038ac0a4ce23e0017"
}

resource "aws_security_group_rule" "dbgroup" {
  security_group_id = "sg-03b16510c28207c78"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id  = tolist(toset(data.aws_instance.existing_instance.vpc_security_group_ids))[0]
}