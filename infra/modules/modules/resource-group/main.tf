resource "azurerm_resource_group" "rsg" {
  provider = azurerm.sub_provider
  for_each = var.resource_groups
  location = each.value["location"]
  name     = each.value["name"]
}