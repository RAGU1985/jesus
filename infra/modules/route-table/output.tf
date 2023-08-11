output "route_table_id" {
  value       = [for x in azurerm_route_table.route_table : x.id]
}
output "rt_ids_map" {
  value = { for x in azurerm_route_table.route_table : x.name => x.id }
}