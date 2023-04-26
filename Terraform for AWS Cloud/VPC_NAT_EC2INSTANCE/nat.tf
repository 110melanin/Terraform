# Configure External IP
resource "aws_eip" "terra-nat-ip" {
  vpc      = true
}

# Nat Gateway

resource "aws_nat_gateway" "terra-nat-gw" {
  allocation_id = aws_eip.terra-nat-ip.id
  subnet_id     = aws_subnet.terra-subnet-public-1.id
  depends_on    = [aws_internet_gateway.terra-gw]
}

# Private Route Table

resource "aws_route_table" "terra-private-rt" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terra-nat-gw.id
  }
}
   tags {
    Name = "terra-private-rt-1"
  }

# Route Association Private

resource "aws_route_table_association" "terra-private-rt-1a" {
  subnet_id      = aws_subnet.terra-subnet-private-1.id
  route_table_id = aws_route_table.terra-private-rt.id
}

resource "aws_route_table_association" "terra-private-rt-2a" {
  subnet_id      = aws_subnet.terra-subnet-private-2.id
  route_table_id = aws_route_table.terra-private-rt.id
}

resource "aws_route_table_association" "terra-private-rt-3a" {
  subnet_id      = aws_subnet.terra-subnet-private-3.id
  route_table_id = aws_route_table.terra-private-rt.id
}


