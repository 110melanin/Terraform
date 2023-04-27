# Security Group for Terra-VPC

resource "aws_security_group" "allow-terra-ssh" {
  name        = "allow_terra_ssh"
  description = "security group to allow ssh connections"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.terra-vpc.id]
    ipv6_cidr_blocks = [aws_vpc.terra-vpc.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-terra-ssh"
  }
}