terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
	region = "eu-west-1"
    #access_key = var.access_key
    #secret_key = var.secret_key
}

resource "aws_instance" "ec2-apache" {
    count = 2
	ami = "ami-0ce1e3f77cd41957e"
	instance_type = "t2.micro"
    user_data = file("userdata.sh")
    vpc_security_group_ids = [
        "sg-0a1aba934688bec2a"
    ]
    key_name = "testec2"
    tags = {
        Name = "tf-ec2-${count.index + 1}"
		project = "training"
	}
}
