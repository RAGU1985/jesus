resource "azurerm_route_table" "route_table" {
  provider                      = azurerm.sub_provider
  for_each                      = var.route_tables
  name                          = each.value["name"]
  location                      = each.value["location"]
  resource_group_name           = each.value["resource_group_name"]
  disable_bgp_route_propagation = lookup(each.value, "disable_bgp_route_propagation", null)

  dynamic "route" {
    for_each = lookup(each.value, "routes", [])
    content {
      name                   = lookup(route.value, "name", null)
      address_prefix         = lookup(route.value, "address_prefix", null)
      next_hop_type          = lookup(route.value, "next_hop_type", null)
      next_hop_in_ip_address = lookup(route.value, "next_hop_in_ip_address", null)
    }
  }
}

locals {
  subnet_route_table_associations = {
    for k, v in var.route_tables : k => v
  }
}

# Associates a Route Table with a Subnet within a Virtual Network
resource "azurerm_subnet_route_table_association" "this" {
  provider                  = azurerm.sub_provider
  for_each       = local.subnet_route_table_associations
  route_table_id = azurerm_route_table.route_table[each.key]["id"]
  subnet_id      = var.aks_subnet
}