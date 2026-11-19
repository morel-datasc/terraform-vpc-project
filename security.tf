provider "aws" {
  region = "ca-central-1"
}

resource "aws_security_group" "create_sg" {
  name        = "morel-sg"
  description = "Security group for morel VPC"
  vpc_id      = aws_vpc.create_vpc.id

  tags = {
    Name = "morel-sg"
  }
}

resource "aws_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.create_sg.id
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}