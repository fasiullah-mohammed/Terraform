provider "aws" {
  region = "us-west-2"  # Replace with your desired AWS region
}

resource "aws_db_instance" "dbgroup" {
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  identifier           = "xxxxxxxxx"
  username             = "xxxxxx"
  password             = "xxxxxxx"
  publicly_accessible = false

  tags = {
    Name = "my-rds-instance"
  }
}

data "aws_instance" "existing_instance" {
  instance_id = "i-xxxxxxxxxxxxxxx"
}

resource "aws_security_group_rule" "dbgroup" {
  security_group_id = "sg-xxxxxxxxxxxxxx"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id  = tolist(toset(data.aws_instance.existing_instance.vpc_security_group_ids))[0]
}
