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
        eu-west-2 = "ami-032a2dcb7c12ce3c2"
        
 }
}

variable "PATH_TO_PUBLIC_KEY" {
    default = "terra_key1.pub"
}