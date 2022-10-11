variable "aws-region" {
  type    = string
  default = "us-east-1"
}

variable "aws-access-key" {
  type = string
}

variable "aws-secret-key" {
  type = string
}


variable "aws-ec2-ami" {
  type    = string
  default = "ami-026b57f3c383c2eec"
}

variable "aws-default-vpc" {
  type = string
}

variable "aws-default-subnet" {
  type = string
}