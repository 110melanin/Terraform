module "ec2_instance" {
  source  = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

  name = "terra-single-instance"

  ami                    = var.AMIS
  instance_type          = "t2.micro"
  key_name               = "justice"
  monitoring             = false
  subnet_id              = "subnet-0fce73655fe99a6ba"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}