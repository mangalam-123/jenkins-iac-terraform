


resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Demo-vpc.id
}


resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.Demo-ec2-instance.id
  port             = 80
}

resource "aws_elb" "bar" {
  name               = "foobar-terraform-elb"
  availability_zones = [ "us-east-2a", "us-east-2b" ]
  
#   access_logs {
#     bucket        = "foo"
#     bucket_prefix = "bar"
#     interval      = 60
#   }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

#   listener {
#     instance_port      = 8000
#     instance_protocol  = "http"
#     lb_port            = 443
#     lb_protocol        = "https"
#     ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
#   }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = [aws_instance.Demo-ec2-instance.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "Custom-elb"
  }
}