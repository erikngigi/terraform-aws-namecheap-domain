resource "aws_route53_zone" "root_domain" {
  name          = var.root_domain
  force_destroy = true
  comment       = "Hosted zone for the root domain managed via namecheap servers"
}

resource "aws_acm_certificate" "wildcard_ssl_certificate" {
  domain_name               = var.root_domain
  subject_alternative_names = ["*.${var.root_domain}"]
  validation_method         = "DNS"
}

resource "aws_route53_record" "certificate_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.wildcard_ssl_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.root_domain.zone_id
}

resource "aws_acm_certificate_validation" "certificate_validation" {
  timeouts {
    create = "5m"
  }
  certificate_arn         = aws_acm_certificate.wildcard_ssl_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_validation_record : record.fqdn]
}
