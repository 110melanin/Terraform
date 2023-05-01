# Variable for Create Instance Module
variable "public_key_path" {
  description = "Public key path"
  default = "terra_key1.pub"
}

variable "VPC_ID" {
    type = string
    default = ""
}

variable "ENVIRONMENT" {
    type    = string
    default = ""
}

variable "AWS_REGION" {
default = "eu-west-2"
}

variable "AMIS" {
    type = map
    default = {
        eu-west-2 = "ami-032a2dcb7c12ce3c2"
        eu-west-1 = "ami-024d2ea3ac8449f5f"
        eu-west-2 = "ami-024d2ea3ac8449f5f"
        eu-west-1 = "ami-024d2ea3ac8449f5f"
    }
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PUBLIC_SUBNETS" {
  type = list
}