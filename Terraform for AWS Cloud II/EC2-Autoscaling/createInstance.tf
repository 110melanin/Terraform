
resource "aws_instance" "terra-instance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.terra_key.key_name
  
  vpc_security_group_ids = [aws_security_group.allow-terra-ssh.id]
  subnet_id = aws_subnet.terra-subnet-public-1.id    


  tags = {
    Name = "terra_instance"
  }
}

