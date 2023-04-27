
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

# EBS Volume Creation

resource "aws_ebs_volume" "terra-ebs" {
  availability_zone = "eu-west-2a"
  size              = 40
  tags = {
    Name = "Secondary Terra Disk"
  }
}

resource "aws_volume_attachment" "terra-ebs-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.terra-ebs.id
  instance_id = aws_instance.terra-instance.id
}

