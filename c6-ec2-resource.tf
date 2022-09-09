

resource "aws_instance" "Demo-ec2-instance" {
    ami = data.aws_ami.linux2.id
    instance_type = var.instance_type
    key_name = var.instance_key
    vpc_security_group_ids = [ aws_security_group.Demo-sg.id]
    subnet_id = aws_subnet.Demo-pub-subnet[0].id
    availability_zone = element(var.Az, 0)
    user_data = file("${path.module}/c2m-install.sh")

    tags = {
      "Name" : "Custom-ec2-instance"
    }
  
}