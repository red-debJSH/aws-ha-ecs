# Create Security Groups for Frontend Internet -> Frontend
resource "aws_security_group" "sg-front" {
  name        = "${var.front}-sg-front"
  description = "Security group for ${var.name} frontend"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.front}-sg-front"
  }

}

resource "aws_vpc_security_group_ingress_rule" "sg-front-ingress" {
  security_group_id = aws_security_group.sg-front.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg-front-egress" {
  security_group_id = aws_security_group.sg-front.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
# Create Security Groups for Backend Frontend -> Backend
resource "aws_security_group" "sg-back" {
  name        = "${var.back}-sg-back"
  description = "Security group for ${var.name} backend"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.back}-sg-back"
  }

}

resource "aws_vpc_security_group_ingress_rule" "sg-back-ingress" {
  security_group_id            = aws_security_group.sg-back.id
  referenced_security_group_id = aws_security_group.sg-front.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg-back-egress" {
  security_group_id = aws_security_group.sg-back.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}



