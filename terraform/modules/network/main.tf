resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.client_name}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.client_name}-public-subnet"
  }
}

resource "aws_subnet" "private_app" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_app_subnet_cidr

  tags = {
    Name = "${var.client_name}-private-app"
  }
}

resource "aws_subnet" "private_db" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_db_subnet_cidr

  tags = {
    Name = "${var.client_name}-private-db"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.client_name}-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.client_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
