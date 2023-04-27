variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIAZXEUEPVWLUI5M2I5"
    }

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "eu-west-2"
}
variable "AMIS" {
    type = map
    default = {
        eu-west-2 = "ami-0582d5cf3037b773a"
        
 }
}

variable "PATH_TO_PUBLIC_KEY" {
    default = "terra_key.pub"
}