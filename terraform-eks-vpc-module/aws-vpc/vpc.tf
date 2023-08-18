/*==== The VPC ======*/
resource "aws_vpc" "vpc_resource" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "${var.general_tag}"
  }
  tags_all = {
    "Name" = "${var.general_tag}"
  }
}


# /*==== Route Table ======*/
# /* The Main route table for the VPC */
resource "aws_route_table" "region_main_public" {
  vpc_id = aws_vpc.vpc_resource.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    "Name" = "${var.general_tag}"
  }
  tags_all = {
    "Name" = "${var.general_tag}"
  }
}

# /*==== Subnets ======*/
# /* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc_resource.id
  tags = {
    "Name" = "${var.general_tag}-igw"
  }
  tags_all = {
    "Name" = "${var.general_tag}-igw"
  }
}

# /* Public subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_resource.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.general_tag}-public-${count.index + 1}"
  }
  tags_all = {
    "Name" = "${var.general_tag}-public-${count.index + 1}"
  }
}

##################################
# /* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
  tags = {
    "Name" = "${var.general_tag}-eip-nat"
  }
}
# /* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    "Name" = "${var.general_tag}-nat"
  }
}
# /* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc_resource.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = {
    "Name" = "${var.general_tag}-private-${count.index + 1}"
  }
  tags_all = {
    "Name" = "${var.general_tag}-private-${count.index + 1}"
  }
}
# /* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc_resource.id
  route {
    nat_gateway_id = aws_nat_gateway.nat.id
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    "Name" = "${var.general_tag}-rt"
  }
}

# /* Route table associations */
resource "aws_route_table_association" "private_rta" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "region_main_rta" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.region_main_public.id
}
