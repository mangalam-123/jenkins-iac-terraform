
resource "aws_security_group" "Demo-sg" {
  
  name = "Custom-sg"
  vpc_id = aws_vpc.Demo-vpc.id
  description = "This is the security grp that allows https and ssh traffic"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "This is to allow ssh from port 22."
    to_port = 22
    from_port = 22
    protocol = "tcp"

  }
 
 ingress {
    cidr_blocks = [var.vpc_cidr]
    description = "Allow http traffic from port 80"
    to_port = 80
    from_port = 80
    protocol = "tcp"
 }

 egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow all traffic from anywhere"
    to_port = 0
    from_port = 0
    protocol = "-1"
 }

 tags = {
   "Name": "Custom-sg"
 }
}
