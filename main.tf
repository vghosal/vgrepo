provider "aws" {
  # Configuration options
  region = "us-east-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"

}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "webserver" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.app_ami.id
}

### Security Group ###
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

}

variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8200, 8201, 8202, 8203]
}

resource "aws_security_group" "sg" {

  name        = "dynamic_sg"
  description = "Ingress"


  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      description      = "TLS from VPC"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
      ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
  }
}