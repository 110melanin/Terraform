# Create Instance using Custom VPC

module "test-vpc" {
  source      = module.terra-vpc.id

  ENVIRONMENT = var.ENVIRONMENT
  AWS_REGION  = var.AWS_REGION
}

provider "aws" {
   region = var.AWS_REGION
}

# Resource key pair

resource "aws_key_pair" "terra_key1" {
  key_name      = "terra_key1"
  public_key    = file(var.public_key_path)
}

#Security Group for Instances
resource "aws_security_group" "terra-ssh" {
  vpc_id      = module.test-vpc.id
  name        = "terra-ssh-${var.ENVIRONMENT}"
  description = "security group that allows ssh traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name         = "terra-ssh"
    Environmnent = var.ENVIRONMENT
  }
}

# Create Instance Group

resource "aws_instance" "terra-instance" {
  ami           = var.AMI_ID
  instance_type = var.INSTANCE_TYPE

  # the VPC subnet
 
  subnet_id = element(module.test-vpc.terra_vpc_id, 0)
  availability_zone = "${var.AWS_REGION}a"

  # the security group
  
  vpc_security_group_ids = ["${aws_security_group.terra-ssh.id}"]

  # the public SSH key
  
  key_name = aws_key_pair.terra_key1.key_name

  tags = {
    Name         = "instance-${var.ENVIRONMENT}"
    Environmnent = var.ENVIRONMENT
  }
}
