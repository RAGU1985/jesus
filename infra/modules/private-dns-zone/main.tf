resource "azurerm_private_dns_resolver" "dnsr" {
  provider            = azurerm.sub_provider
  for_each            = var.private_dns_resolvers
  location            = each.value["location"]
  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  virtual_network_id  = replace(replace(replace(var.virtual_network_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", each.value["resource_group_name"]), "virtualNetworkName", each.value["virtual_network_name"])
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "rie" {
  provider                = azurerm.sub_provider
  for_each                = var.private_dns_resolver_inbound_endpoints
  location                = each.value["location"]
  name                    = each.value["name"]
  private_dns_resolver_id = replace(replace(replace(var.private_dns_resolver_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", each.value["resource_group_name"]), "dnsResolverName", each.value["private_dns_resolver_name"])

  dynamic "ip_configurations" {
    for_each = coalesce(lookup(each.value, "ip_configurations"), [])
    content {
      subnet_id = replace(replace(replace(replace(var.subnet_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", lookup(ip_configurations.value, "resource_group_name", null)), "virtualNetworkName", lookup(ip_configurations.value, "virtual_network_name", null)), "subnetName", lookup(ip_configurations.value, "subnet_name", null))
    }
  }

  depends_on = [
    azurerm_private_dns_resolver.dnsr
  ]
}

resource "azurerm_private_dns_zone" "dnsz" {
  provider            = azurerm.sub_provider
  for_each            = var.private_dns_zones
  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnl" {
  provider              = azurerm.sub_provider
  for_each              = var.private_dns_zone_virtual_network_links
  name                  = each.value["name"]
  private_dns_zone_name = each.value["private_dns_zone_name"]
  resource_group_name   = each.value["resource_group_name"]
  virtual_network_id    = replace(replace(replace(var.virtual_network_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", each.value["resource_group_name"]), "virtualNetworkName", each.value["virtual_network_name"])

  depends_on = [
    azurerm_private_dns_resolver.dnsr
  ]
}


