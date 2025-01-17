resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name} ${var.internet_gateway_name}"
  }
}

resource "aws_subnet" "subnet_private_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_private_a_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.vpc_name}_sub_priv_a"
  }
}

resource "aws_subnet" "subnet_private_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_private_b_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.vpc_name}_sub_priv_b"
  }
}

resource "aws_subnet" "subnet_public_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_public_a_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.vpc_name}_sub_pub_a"
  }
}

resource "aws_subnet" "subnet_public_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_public_b_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.vpc_name}_sub_pub_b"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.vpc_name}_pub_rt"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.vpc_name}_priv_rt"
  }
}

resource "aws_route_table_association" "subnet_private_a" {
  subnet_id      = aws_subnet.subnet_private_a.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "subnet_private_b" {
  subnet_id      = aws_subnet.subnet_private_b.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "subnet_public_a" {
  subnet_id      = aws_subnet.subnet_public_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "subnet_public_b" {
  subnet_id      = aws_subnet.subnet_public_b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name         = var.domain_name
  domain_name_servers = [var.dns]
  tags = {
    Name = "${var.vpc_name}_dhcp_opt"
  }
}

resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
}

resource "aws_eip" "elastic_ip" {
  domain = "vpc"

  tags = {
    Name = "${var.vpc_name}_eip_nat_gw"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.subnet_public_a.id

  tags = {
    Name = "${var.vpc_name}_nat_gw"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}