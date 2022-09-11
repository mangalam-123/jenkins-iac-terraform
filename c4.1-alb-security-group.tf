
resource "aws_security_group" "Demo-alb" {
  name = "Custom-alb-sg"
  vpc_id = aws_vpc.Demo-vpc.id
  description = "This is a custom sg for alb"

  ingress{
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow traffic from port 80 from anywhere"
    to_port = 80
    from_port = 80
    protocol = "tcp"
  }

  egress{
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all traffic from anywhere"
    to_port = 0
    from_port = 0
    protocol = "-1"
  }

  tags = {
    "Name": "Custom-alb-sg"
  }
}