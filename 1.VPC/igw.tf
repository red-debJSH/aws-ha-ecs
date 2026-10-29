resource "aws_internet_gateway" "igw" {
  provider = aws
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "${local.project}-igw"
  }
}