
resource "aws_key_pair" "terra_key" {
    key_name = "terra_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "terra-instance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.terra_key.key_name

  tags = {
    Name = "terra_instance"
  }
}