output "domain_name" {
  value = aws_instance.web.public_dns
}

output "application_url" {
  value = "${aws_instance.web.public_dns}/index.php"
}
