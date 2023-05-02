#Custom VPC for my Project 
module "terra-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${var.ENVIRONMENT}"
  cidr = "10.0.0.0/16"

  azs             = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.ENVIRONMENT
  }
}

#Output Specific to Custom VPC

output "terra_vpc_id" {
  description = "VPC ID"
  value       = module.terra-vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.terra-vpc.public_subnets
}