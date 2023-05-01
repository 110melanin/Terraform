provider "aws" {
  region       = var.AWS_REGION
}

module "ec2_instance" {
  source  = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

  name = "terra-single-instance"

  ami                    =  "ami-032a2dcb7c12ce3c2"
  monitoring             = false
  subnet_id              = "subnet-0fce73655fe99a6ba"
  count                  = var.environment == "Production" ? 2 : 1


  tags = {
    Terraform   = "true"
    Environment = "var.environment"
  }
}