

resource "aws_lb" "test" {
  name               = "Demo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Demo-alb.id]
  subnets            = [for subnet in aws_subnet.Demo-pub-subnet : subnet.id]

  enable_deletion_protection = false

  tags = {
    "Name": "Custom-alb"
  }
}

resource "aws_alb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn

  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.Demo-tg.arn
  }
  
}

resource "aws_lb_target_group" "Demo-tg" {
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.Demo-vpc.id
  

  stickiness {
    enabled = true
    type = "lb_cookie"
  }

  health_check {
    healthy_threshold = 2
    interval = 30
    protocol = "HTTP"
    unhealthy_threshold = 2

  }

  depends_on = [
    aws_lb.test
  ]
}


resource "aws_lb_target_group_attachment" "Demo" {
  target_group_arn = aws_lb_target_group.Demo-tg.arn
  target_id        = aws_instance.Demo-ec2-instance.id
  port             = 80
}
