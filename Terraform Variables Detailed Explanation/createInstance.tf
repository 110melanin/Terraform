
resource "aws_instance" "MyFirstInstance" {
  ami           = lookup(var.AMI, var.AWS_REGION)
  instance_type = "t2.micro"

  tags = {
    Name = "demoinstance"
  }

  security_groups = var.Security_Group
}