# Security Group for Terra-VPC

resource "aws_security_group" "allow-terra-ssh" {
  name        = "allow-terra-ssh"
  description = "security group to allow ssh connections"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow-terra-ssh"
  }
}

# Security Group for MariaDB

resource "aws_security_group" "allow-mariadb" {
  name        = "allow-mariadb"
  description = "security group for ariaDB connections"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_groups = [aws_security_group.allow-terra-ssh.id]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-mariadb"
  }
}