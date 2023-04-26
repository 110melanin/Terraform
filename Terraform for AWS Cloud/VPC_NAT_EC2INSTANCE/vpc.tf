# Create AWS VPC
resource "aws_vpc" "terra-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"

  tags = {
    Name = "terra-vpc"
  }
}

# Create AWS Subnets (Subnet 1)

resource "aws_subnet" "terra-vpc-public-1" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "terra-vpc-public-1"
  }
}

# Create AWS Subnets (Subnet 2)
resource "aws_subnet" "terra-vpc-public-2" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "terra-vpc-public-2"
  }
}

# Create AWS Subnets (Subnet 3)
resource "aws_subnet" "terra-vpc-public-3" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2c"

  tags = {
    Name = "terra-vpc-public-3"
  }
}

# Private Subnets in Custom VPC (Subnet 1)
resource "aws_subnet" "terra-vpc-private-1" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "terra-vpc-private-1"
  }
}

# (Subnet 2)
resource "aws_subnet" "terra-vpc-private-2" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "terra-vpc-private-2"
  }
}

# (Subnet 3)
resource "aws_subnet" "terra-vpc-private-3" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-2c"

  tags = {
    Name = "terra-vpc-private-3"
  }
}

# Custom Internet Gateway
resource "aws_internet_gateway" "terra-gw" {
  vpc_id = aws_vpc.terra-vpc.id

  tags = {
    Name = "terra-gw"
  }
}

# Custom Route Tables for CustomVPC

resource "aws_route_table" "terra-public-rt" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-gw.id
  }
}
  tags = {
    Name = "terra-public-rt-1"
  }

resource "aws_route_table_association" "terra-public-rt-1a" {
  subnet_id      = aws_subnet.terra-vpc-public-1.id
  route_table_id = aws_route_table.terra-public-rt.id
}

resource "aws_route_table_association" "terra-public-rt-2a" {
  subnet_id      = aws_subnet.terra-vpc-public-2.id
  route_table_id = aws_route_table.terra-public-rt.id
}

resource "aws_route_table_association" "terra-public-rt-3a" {
  subnet_id      = aws_subnet.terra-vpc-public-3.id
  route_table_id = aws_route_table.terra-public-rt.id
}