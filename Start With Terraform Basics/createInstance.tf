
resource "aws_instance" "MyFirstInstance" {
  count         = 2
  ami           = "ami-0eb27879c20e8bf16"
  instance_type = "t2.micro"

  tags = {
    Name = "demoinstance-${count.index}"
  }
}