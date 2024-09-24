resource "aws_db_instance" "main" {
  identifier = "licdb"
  allocated_storage = 10
  db_name = "mysqlrds"
  engine = "mysql"
  instance_class = "db.t3.micro"
  engine_version = "8.0"
  username = var.rds_username
  password = var.rds_password
  parameter_group_name = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_security_group" "rds_sg" {
  name = "mysqlrds_sg"
  ingress  {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
    description = "Mysql Port"
  }

  egress {
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All Trafice"
  }

  tags = {
    "Name" = "RDS SG For MYSQL"
  }

}