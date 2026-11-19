resource "aws_security_group" "create_sg" {
  name        = "morel-sg"
  description = "Security group for morel VPC"
  vpc_id      = aws_vpc.create_vpc.id

  tags = {
    Name = "morel-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.create_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol    = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.create_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}