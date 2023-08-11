resource "azurerm_virtual_wan" "vwan" {
  provider            = azurerm.sub_provider
  for_each            = var.virtual_wans
  location            = each.value["location"]
  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
}

resource "azurerm_virtual_hub" "vhub" {
  provider            = azurerm.sub_provider
  for_each            = var.virtual_hubs
  address_prefix      = each.value["address_prefix"]
  location            = each.value["location"]
  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  sku                 = each.value["sku"]
  virtual_wan_id      = replace(replace(replace(var.virtual_wan_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", each.value["resource_group_name"]), "virtualWanName", each.value["virtual_wan_name"])
  
  depends_on = [
    azurerm_virtual_wan.vwan,
  ]
}

resource "azurerm_express_route_gateway" "exg" {
  provider            = azurerm.sub_provider
  for_each            = var.express_route_gateways
  location            = each.value["location"]
  name                = each.value["name"]
  resource_group_name = each.value["resource_group_name"]
  scale_units         = each.value["scale_units"]
  virtual_hub_id      = replace(replace(replace(var.virtual_hub_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", each.value["resource_group_name"]), "virtualHubName", each.value["virtual_hub_name"])
  
  depends_on = [
    azurerm_virtual_hub.vhub,
  ]
}

resource "azurerm_virtual_hub_route_table" "rt" {
  provider            = azurerm.sub_provider
  for_each            = var.virtual_hub_route_tables
  labels              = each.value["labels"]
  name                = each.value["name"]
  virtual_hub_id      = replace(replace(replace(var.virtual_hub_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", each.value["resource_group_name"]), "virtualHubName", each.value["virtual_hub_name"])
  
  depends_on = [
    azurerm_virtual_hub.vhub,
  ]
}

resource "azurerm_virtual_hub_connection" "vhc" {
  provider                  = azurerm.sub_provider
  for_each                  = var.virtual_hub_connections
  internet_security_enabled = each.value["internet_security_enabled"]
  name                      = each.value["name"]
  remote_virtual_network_id = replace(replace(replace(var.virtual_network_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", each.value["remote_resource_group_name"]), "virtualNetworkName", each.value["remote_virtual_network_name"])
  virtual_hub_id            = replace(replace(replace(var.virtual_hub_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", each.value["resource_group_name"]), "virtualHubName", each.value["virtual_hub_name"])
  
  depends_on = [
    azurerm_virtual_hub.vhub
  ]
}