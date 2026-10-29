## Zona 2a
resource "aws_route_table" "private_rt" {
  for_each = local.private_subnets
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[each.key].id
  }

  tags = {
    Name = "${local.project}-private-subnet-${each.value.az}-rt"
  }
}

resource "aws_route_table_association" "private" {
  for_each = local.private_subnets
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private_rt[each.key].id
}
