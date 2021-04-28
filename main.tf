terraform {
  backend "remote" {
    hostname      = "app.terraform.io"
    organization  = "hashicorp-learn"

    workspaces {
      name = "learn-terraform-versions"
    }
  }  

  required_providers {
    aws = {
      #      source = "hashicorp/aws"
      version = "~> 2.13.0"
    }
    random = {
      #      source = "hashicorp/random"
      version = ">= 2.1.2"
    }
  }

#  required_version = "~> 0.12.29"
  required_version = "0.15.0"
}

provider "aws" {
  region = "us-west-2"
}

provider "random" {}

resource "random_pet" "name" {}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  user_data     = file("init-script.sh")

  tags = {
    Name = random_pet.name.id
  }
}
