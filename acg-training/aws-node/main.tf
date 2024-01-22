provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-03e0029f86a2c74c3"
  subnet_id     = "subnet-bc3e12e7"
  instance_type = "t3.medium"
  tags = {
    Name        = "kourosh-ec2-instance"
    DoNotDelete = "true"
  }
}

