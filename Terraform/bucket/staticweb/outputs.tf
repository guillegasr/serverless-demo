output "webapp_domain" {
  value = "${aws_s3_bucket.webapp.website_domain}"
}

output "webapp_endpoint" {
  value = "${aws_s3_bucket.webapp.website_endpoint}"
}

output "webapp_arn" {
  value = "${aws_s3_bucket.webapp.arn}"
}
