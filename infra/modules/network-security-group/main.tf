resource "azurerm_network_security_group" "nsg" {
  provider            = azurerm.sub_provider
  for_each            = var.network_security_groups
  location            = each.value["location"]
  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]

  dynamic "security_rule" {
    for_each = lookup(each.value, "security_rules", [])
    content {
      name                         = security_rule.value["name"]
      description                  = lookup(security_rule.value, "description", null)
      protocol                     = coalesce(security_rule.value["protocol"], "Tcp")
      direction                    = security_rule.value["direction"]
      access                       = coalesce(security_rule.value["access"], "Allow")
      priority                     = security_rule.value["priority"]
      source_address_prefix        = lookup(security_rule.value, "source_address_prefix", null)
      source_address_prefixes      = lookup(security_rule.value, "source_address_prefixes", null)
      destination_address_prefix   = lookup(security_rule.value, "destination_address_prefix", null)
      destination_address_prefixes = lookup(security_rule.value, "destination_address_prefixes", null)
      source_port_range            = lookup(security_rule.value, "source_port_range", null)
      source_port_ranges           = lookup(security_rule.value, "source_port_ranges", null)
      destination_port_range       = lookup(security_rule.value, "destination_port_range", null)
      destination_port_ranges      = lookup(security_rule.value, "destination_port_ranges", null)
    }
  }
}