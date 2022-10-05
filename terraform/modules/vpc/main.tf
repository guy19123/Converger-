# This is main file under vpc module to create vpc

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = var.tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = var.tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true

  cidr_block        = var.public_subnets[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = var.tags

  count = length(var.public_subnets)
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  tags = var.tags
}

resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public-association" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public-rt.id
}
