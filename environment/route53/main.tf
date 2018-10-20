data "aws_route53_zone" "this_zone" {
  zone_id = "${var.zone_id}"
}

resource "aws_route53_record" "this_record" {
  zone_id = "${data.aws_route53_zone.this_zone.zone_id}"
  name = "${var.subdomain}.${data.aws_route53_zone.this_zone.name}"
  type = "A"
  ttl = "300"
  records = ["${var.ip}"]
}