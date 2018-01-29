output "alb_dns_name" {
  value = "${aws_alb.app.dns_name}"
}

output "alb_arn" {
  value = "${aws_alb.app.arn}"
}

output "alb_id" {
  value = "${aws_alb.app.id}"
}
