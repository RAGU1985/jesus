output "resource_group" {
  value = azurerm_resource_group.resource_group.id
}

output "eventHubs_namespace" {
  value = azurerm_eventhub_namespace.eventhub_namespace.name
}

output "event_hubs" {
  value = azurerm_eventhub.eventhub_resource.name
}

output "activity_logs" {
  value = azurerm_monitor_diagnostic_setting.diag-setting.name
}

output "private_endpoint" {
  value = azurerm_private_endpoint.private_endpoint.name
}
