
resource "aws_key_pair" "terra_key1" {
    key_name = "terra_key1"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "terra-instance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = "eu-west-2a"
  key_name      = aws_key_pair.terra_key1.key_name
  vpc_security_group_ids = [aws_security_group.allow-terra-ssh.id]
  subnet_id     = aws_subnet.terra-subnet-public-1.id

  tags = {
    Name = "terra_instance"
  }
}

output "public_ip" {
  value = aws_instance.terra-instance.public_ip
}
