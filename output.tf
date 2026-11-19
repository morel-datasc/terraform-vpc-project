output "public_ip" {
  type = string
  value = aws_instance.create_instance.public_ip
  description = "Public IP address of the created EC2 instance"
  depends_on = [aws_instance.create_instance]
}