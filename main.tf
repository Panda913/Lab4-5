terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
# Оголошення провайдера для Terraform 
provider "aws" {
  access_key = "AKIARVVK42DMZFXDTF4Y"
  secret_key = "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"
  region = "eu-north-1"
}


# Створення Security Group
resource "aws_security_group" "web_sg" {
  name        = "Lab6"
  description = "Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami                         = "ami-064087b8d355e9051"
  instance_type               = "t3.micro"
  key_name                    = "lab4"
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

}
