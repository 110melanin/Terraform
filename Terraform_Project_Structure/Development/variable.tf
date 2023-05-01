provider "aws" {
  region       = var.AWS_REGION
}

variable "AWS_REGION" {
    type    = string
    default = "eu-west-2"
}


variable "ENVIRONMENT" {
    type    = string
    default = "production"
}