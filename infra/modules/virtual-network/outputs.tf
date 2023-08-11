output "virtual_network" {
  value = azurerm_virtual_network.vn
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
  value       = [for x in azurerm_virtual_network.vn : x.id]
  description = "IDs of the subnets."

}