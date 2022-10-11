# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = var.aws-access-key
  secret_key = var.aws-secret-key
  region     = var.aws-region
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity-t2" {
  subnet_id     = var.aws-default-subnet
  instance_type = "t2.micro"
  ami           = var.aws-ec2-ami
  count         = 4
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
/*
resource "aws_instance" "udacity-m4" {
  subnet_id     = var.aws-default-subnet
  instance_type = "m4.large"
  ami           = var.aws-ec2-ami
  count         = 2
}
*/
