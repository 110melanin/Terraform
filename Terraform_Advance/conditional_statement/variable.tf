variable "AWS_REGION" {
    type        = string
    default     = "eu-west-2"
}

variable "environment" {
    type        = string
    default     = "Development"
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}