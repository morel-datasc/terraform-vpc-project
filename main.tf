provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "create_instance" {
  ami           = "ami-0f3762ba952fec834 "
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.create_pub_subnet.id
  security_groups = [aws_security_group.create_sg.name]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "morel-nginx-instance"
  }
}