

resource "aws_route53_record" "myapp" {
   depends_on = [
    aws_lb.test
  ]
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name = "myapp.myappstore.tech"
  type = "A"

  alias {
    name = aws_lb.test.dns_name
    zone_id = aws_lb.test.zone_id
    evaluate_target_health = true
  }
}
