
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
}

# Створення VM instance
resource "aws_instance" "web_server" {
  ami  = var.ami_id
  instance_type = "t2.micro" 


  # Підключення Security Group до інстансу
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Установка Docker після створення інстансу
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              EOF
}

# Оголошення виводу публічної IP-адреси інстансу
output "public_ip" {
  value = aws_instance.web_server.public_ip
}
