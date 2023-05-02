# Variable for Create Instance Module
variable "public_key_path" {
  description = "Public key path"
  default = "terra_key2.pub"
}

variable "AWS_SECRET_KEY" {}

variable "VPC_ID" {
    type = string
    default = ""
}

variable "ENVIRONMENT" {
    type    = string
    default = ""
}

variable "AMI_ID" {
    type    = string
    default = ""
}

variable "AWS_REGION" {
default = "eu-west-2"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

