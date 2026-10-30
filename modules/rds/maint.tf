# Create Security Groups for Database Backend -> Database
resource "aws_security_group" "sg-db" {
  name        = var.sg_name
  description = "Security group for ${var.name} database"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.sg_name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sg-db-ingress" {
  security_group_id            = aws_security_group.sg-db.id
  referenced_security_group_id = var.backend_sg_id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg-db-egress" {
  security_group_id = aws_security_group.sg-db.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
# Create RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = values(var.private_subnets)

  tags = {
    Name = "${var.name}-db-subnet-group"
  }
}
# Create Random Password for RDS
resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
# Create RDS Instance
resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  identifier             = "${var.name}-db"
  db_name                = "${var.name}DB"
  engine                 = "mysql"
  engine_version         = "8.4.11"
  instance_class         = "db.t3.micro"
  username               = var.username
  password               = random_password.rds_password.result
  vpc_security_group_ids = [aws_security_group.sg-db.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot    = true
}