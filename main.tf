provider "aws" {
  # Configuration options
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

data "aws_ami" "app_ami"{
most_recent=true
owners=["amazon"]

filter {
    name= "name"
    values=["amzn2-ami-hvm*"]
}
}


resource "aws_instance" "webserver"{
  instance_type = "t2.micro"
  ami= data.aws_ami.app_ami.id
  }

