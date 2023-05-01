variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "eu-west-2"
}

variable "Security_Group"{
    type = list
    default = ["terranginx", "terratomcat", "terrards"]
}

variable "AMIS" {
    type = map
    default = {
        eu-west-2 = "ami-0582d5cf3037b773a"
        
 }
}