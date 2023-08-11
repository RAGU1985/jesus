data "azurerm_virtual_network" "vnet" {
  name     = "vnet-itaudev-sbx-test-networking-001"
  resource_group_name = "rg-aks-brazilsouth-dev-001"
}

resource "azurerm_subnet" "snet" {
  provider                                      = azurerm.sub_provider
  for_each                                      = var.subnets
  address_prefixes                              = each.value["address_prefixes"]
  name                                          = each.value["name"]
  private_endpoint_network_policies_enabled     = coalesce(lookup(each.value, "private_endpoint_network_policies_enabled"), false)
  private_link_service_network_policies_enabled = coalesce(lookup(each.value, "private_endpoint_network_policies_enabled"), false)
  resource_group_name                           = each.value["resource_group_name"]
  service_endpoints                             = lookup(each.value, "service_endpoints", null)
  virtual_network_name                          = "vnet-itaudev-sbx-test-networking-001"

  dynamic "delegation" {
    for_each = coalesce(lookup(each.value, "delegation"), [])
    content {
      name = lookup(delegation.value, "name", null)
      dynamic "service_delegation" {
        for_each = coalesce(lookup(delegation.value, "service_delegation"), [])
        content {
          name    = lookup(service_delegation.value, "name", null)
          actions = lookup(service_delegation.value, "actions", null)
        }
      }
    }
  }

  depends_on = [
    data.azurerm_virtual_network.vnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  provider                  = azurerm.sub_provider
  for_each                  = var.subnet_network_security_group_associations
  network_security_group_id = replace(replace(replace(var.network_security_group_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", each.value["resource_group_name"]), "networkSecurityGroupName", each.value["network_security_group_name"])
  subnet_id                 = replace(replace(replace(replace(var.subnet_id_template, "subscriptionId", var.subscription_id), "resourceGroupName", each.value["resource_group_name"]), "virtualNetworkName", each.value["virtual_network_name"]), "subnetName", each.value["subnet_name"])

  depends_on = [
    azurerm_subnet.snet
  ]
}
/* locals {
  vnet_association = {
    for k, v in var.virtual_networks : k => v
  }
}
resource "azurerm_role_assignment" "azurerm_network_contributor" {
  for_each = local.vnet_association
  scope = azurerm_virtual_network.vn[each.key]["id"]
  role_definition_name = "Network Contributor"
  principal_id =var.managed_identity
} */