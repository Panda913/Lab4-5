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
  access_key = var.access_key
  secret_access_key = var.secret_access_key
  region = "eu-north-1"
}


# Створення Security Group
resource "aws_security_group" "web_sg" {
  name        = "web_security_group"
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

# Створення VM instance
resource "aws_instance" "web_server" {
  ami  = var.ami_id
  instance_type = "t2.micro" 
  key_name                    = "iit-lab4"

  # Підключення Security Group до інстансу
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  # Установка Docker після створення інстансу
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              EOF
  tags = {
    Name = "Lab6"
  }
}

