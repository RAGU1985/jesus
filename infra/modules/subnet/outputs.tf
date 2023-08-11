output "virtual_network" {
  value = data.azurerm_virtual_network.vnet
}

output "subnet" {
  value = azurerm_subnet.snet
 }
/* output "subnet_id" {
  value = azurerm_subnet.snet.id
  
}  */
output "subnet_ids" {
  value       = [for x in azurerm_subnet.snet : x.id]
  description = "IDs of the subnets."

}
output "vnet_ids" {
  value       = "/subscriptions/d7caf0f4-7c69-4c4a-af92-3b52493f74ca/resourceGroups/rg-aks-brazilsouth-dev-001/providers/Microsoft.Network/virtualNetworks/vnet-itaudev-sbx-test-networking-001"
  description = "IDs of the subnets."

}