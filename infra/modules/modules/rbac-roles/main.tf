resource "azurerm_role_assignment" "azurerm_network_contributor" {
  scope = var.vnet_id
  role_definition_name = "Network Contributor"
  principal_id =var.managed_identity_id
}
resource "azurerm_role_assignment" "azurerm_private_dns_zone_contributor" {
  scope = var.dns_id
  role_definition_name = "Network Contributor"
  principal_id =var.managed_identity_id
}
