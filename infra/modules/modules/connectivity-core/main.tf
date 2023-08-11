resource "null_resource" "subscription" {

  triggers = {
    "subscription" = var.subscription_id
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "${var.subscription_id}"
    EOT
  }
}

module "resource_group" {
  source = "../resource-group"

  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }

  subscription_id = var.subscription_id
  resource_groups = var.resource_groups
}

module "network_security_group" {
  source = "../network-security-group"

  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }

  subscription_id         = var.subscription_id
  network_security_groups = var.network_security_groups

  depends_on = [
    module.resource_group.resource_group
  ]
}

module "virtual_network" {
  source = "../virtual-network"

  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }

  subscription_id                            = var.subscription_id
  virtual_networks                           = var.virtual_networks
  subnets                                    = var.subnets
  virtual_network_peerings                   = var.virtual_network_peerings
  subnet_network_security_group_associations = var.subnet_network_security_group_associations

  depends_on = [
    module.resource_group.resource_group,
    module.network_security_group.network_security_group
  ]
}

module "virtual_wan" {
  source = "../virtual-wan"

  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }

  subscription_id          = var.subscription_id
  virtual_wans             = var.virtual_wans
  virtual_hubs             = var.virtual_hubs
  express_route_gateways   = var.express_route_gateways
  virtual_hub_route_tables = var.virtual_hub_route_tables
  virtual_hub_connections  = var.virtual_hub_connections

  depends_on = [
    module.resource_group.resource_group,
    module.network_security_group.network_security_group
  ]
}

module "private_dns_zone" {
  source = "../private-dns-zone"

  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }

  subscription_id                        = var.subscription_id
  private_dns_resolvers                  = var.private_dns_resolvers
  private_dns_resolver_inbound_endpoints = var.private_dns_resolver_inbound_endpoints
  private_dns_zones                      = var.private_dns_zones
  private_dns_zone_virtual_network_links = var.private_dns_zone_virtual_network_links

  depends_on = [
    module.resource_group.resource_group,
    module.virtual_network.virtual_network,
    module.virtual_network.subnet
  ]
}
