# Create VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}
# Create PUBLIC subnets
resource "aws_subnet" "public" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet-${each.value.az}"
  }
}
# Create PRIVATE subnets 
resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.name}-private-subnet-${each.value.az}"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-igw"
  }
}

# Create NAT Gateways
resource "aws_eip" "ngw" {
  for_each = var.private_subnets
  domain   = "vpc"

  tags = {
    Name = "${var.name}-nat-${each.value.az}"
  }
}

resource "aws_nat_gateway" "ngw" {
  for_each      = var.private_subnets
  allocation_id = aws_eip.ngw[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = "${var.name}-nat-${each.value.az}"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Create PUBLIC route tables and associate them with public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name}-public-subnets-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public_rt.id
}

# Create PRIVATE route tables and associate them with private subnets
resource "aws_route_table" "private_rt" {
  for_each = var.private_subnets
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[each.key].id
  }

  tags = {
    Name = "${var.name}-private-subnet-${each.value.az}-rt"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = var.private_subnets
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private_rt[each.key].id
}
