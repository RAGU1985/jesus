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
  value       = [for x in data.azurerm_virtual_network.vnet : x.id]
  description = "IDs of the subnets."

}