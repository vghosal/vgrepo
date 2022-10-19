
provider "aws" {
  # Configuration options
  region = "ap-southeast-1"
  access_key = "AKIAYAAWXR7UDVL6RYC6"
  secret_key = "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"
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

