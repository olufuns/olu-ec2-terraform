resource "aws_instance" "olu_ec2_app" {
  ami           = "ami-06cdac14c9c4da91b"
  instance_type = "t3.micro"
  key_name      = "funso"


  tags = {
    Name        = "olu-ec2-app"
    Environment = "Dev"
  }
}