
resource "aws_eip" "ngw" {
  for_each = local.private_subnets
  domain = "vpc"

  tags = {
    Name = "${local.project}-private-subnet-${each.value.az}"
  }
}

resource "aws_nat_gateway" "ngw" {
  for_each = local.private_subnets
  allocation_id = aws_eip.ngw[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = "${local.project}-private-subnet-${each.value.az}"
  }

  depends_on = [aws_internet_gateway.igw]
}
