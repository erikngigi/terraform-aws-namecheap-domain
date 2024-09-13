module "network_module" {
  source      = "./modules/network"
  root_domain = var.root_domain
}
