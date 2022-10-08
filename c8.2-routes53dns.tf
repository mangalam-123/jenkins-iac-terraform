

resource "aws_route53_record" "myapp" {
  
  depends_on = [
    aws_alb.test
  ]

  zone_id = data.aws_route53_zone.mydomain.zone_id
  name = "www.myappstore.tech"
  type = "A"

  alias {
    name = aws_alb.test.dns_name
    zone_id = aws_alb.test.zone_id
    evaluate_target_health = true
  }
}
