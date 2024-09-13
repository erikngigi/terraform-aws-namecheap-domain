output "route53_name_servers" {
  description = "Name servers generated on aws route53 for namecheap custom dns"
  value       = aws_route53_zone.root_domain.name_servers
}

output "route53_zone_id" {
  description = "Zone ID for the domain hosted on route 53"
  value       = aws_route53_zone.root_domain.zone_id
}
