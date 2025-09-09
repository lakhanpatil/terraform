provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "vm" {
  ami             = "ami-070b7c2988d4e2c89"
  subnet_id       = "subnet-07ced0794529053b8"
  instance_type   = "t3.micro"
  tags = {
    name = "my-first-tf-node"
  }
}
