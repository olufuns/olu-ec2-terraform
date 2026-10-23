resource "aws_instance" "olu_ec2_app" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.olu_app_sg.id]
  user_data = filebase64("userdata.sh")


  tags = {
    Name        = "olu-app-${var.environment}"
    Environment = var.environment
  }
}