# Datasource: Route53 Hosted Zone
data "aws_route53_zone" "selected" {
  name         = "lishprj.link."
}
# Resource: ACM Certificate
resource "aws_acm_certificate" "acm_cert" {
  domain_name       = "*.${data.aws_route53_zone.selected.name}"
  # domain_name       = "*.lishprj.link"
  subject_alternative_names = [data.aws_route53_zone.selected.name]
  # subject_alternative_names = ["lishprj.link"]
  validation_method = "DNS"
  tags = {
    Environment = "dev"
  }
  lifecycle {
    create_before_destroy = true
  }
}
# Outputs
output "aws_route53_zone_name" {
  value = data.aws_route53_zone.selected.name
}
output "acm_certificate_id" {
  value = aws_acm_certificate.acm_cert.id 
}
output "acm_certificate_arn" {
  value = aws_acm_certificate.acm_cert.arn
}
output "acm_certificate_status" {
  value = aws_acm_certificate.acm_cert.status
}