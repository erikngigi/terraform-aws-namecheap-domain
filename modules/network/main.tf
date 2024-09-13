resource "aws_route53_zone" "root_domain" {
  name          = var.root_domain
  force_destroy = true
  comment       = "Hosted zone for the root domain managed via namecheap servers"
}
