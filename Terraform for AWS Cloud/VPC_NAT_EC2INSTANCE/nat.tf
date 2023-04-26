# Configure External IP
resource "aws_eip" "terra-nat" {
  vpc      = true
}