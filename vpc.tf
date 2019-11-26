# Internet VPC
resource "aws_vpc" "tag-demo" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "tag-demo"
  }
}

# Subnets
resource "aws_subnet" "tag-demo-public-1" {
  vpc_id                  = aws_vpc.tag-demo.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2a"

  tags = {
    Name = "tag-demo-public-1"
  }
}

resource "aws_subnet" "tag-demo-public-2" {
  vpc_id                  = aws_vpc.tag-demo.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2b"

  tags = {
    Name = "tag-demo-public-2"
  }
}

resource "aws_subnet" "tag-demo-private-1" {
  vpc_id                  = aws_vpc.tag-demo.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2a"

  tags = {
    Name = "tag-demo-private-1"
  }
}

resource "aws_subnet" "tag-demo-private-2" {
  vpc_id                  = aws_vpc.tag-demo.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2b"

  tags = {
    Name = "tag-demo-private-2"
  }
}

# Internet GW
resource "aws_internet_gateway" "tag-demo-gw" {
  vpc_id = aws_vpc.tag-demo.id

  tags = {
    Name = "tag-demo"
  }
}

# route tables
resource "aws_route_table" "tag-demo-public" {
  vpc_id = aws_vpc.tag-demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tag-demo-gw.id
  }

  tags = {
    Name = "tag-demo-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "tag-demo-public-1-a" {
  subnet_id      = aws_subnet.tag-demo-public-1.id
  route_table_id = aws_route_table.tag-demo-public.id
}

resource "aws_route_table_association" "tag-demo-public-2-a" {
  subnet_id      = aws_subnet.tag-demo-public-2.id
  route_table_id = aws_route_table.tag-demo-public.id
}
