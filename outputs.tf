# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "domain_name" {
  description = "Public DNS name of the EC2 instance."
  value       = aws_instance.web.public_dns
}

output "application_url" {
  description = "URL of the example application."
  value       = "${aws_instance.web.public_dns}/index.php"
}
