variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "eu-west-2"
}

variable "Security_Group"{
    type = list
    default = ["nginx", "tomcat", "rds"]
}

variable "AMI" {
    type = map
    default = {
        eu-west-2 = "ami-0eb27879c20e8bf16"
        
        
    }
}