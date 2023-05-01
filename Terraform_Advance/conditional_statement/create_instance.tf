provider "aws" {
  region       = var.AWS_REGION
}

module "ec2_instance" {
  source  = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

  name = "terra-single-instance"

  ami                    =  "ami-032a2dcb7c12ce3c2"
  instance_type          = "t2.micro"
  monitoring             = false
  subnet_id              = "subnet-0fce73655fe99a6ba"
  instance_type        = var.instance_type == "t3.micro" ? 1 : 2


  tags = {
    Terraform   = "true"
    Environment = "var.environment"
  }
}