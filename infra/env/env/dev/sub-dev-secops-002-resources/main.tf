#Event Hubs Resource Group Deploy
resource "azurerm_resource_group" "resource_group" {
  provider = azurerm.sub_provider
  name     = var.resource_group_name
  location = var.location
}

#Event Hubs Namespace Deploy
resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  provider                      = azurerm.sub_provider
  name                          = var.eventhub_namespace_name
  location                      = var.location
  resource_group_name           = azurerm_resource_group.resource_group.name
  sku                           = "Standard"
  capacity                      = 2
  public_network_access_enabled = false
}

#Event Hubs Deploy
resource "azurerm_eventhub" "eventhub_resource" {
  provider            = azurerm.sub_provider
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = var.resource_group_name
  partition_count     = 4
  message_retention   = 1
}

#Event Hubs Shared Access Policies, required to associate the Diagnotisc Settings to Event hubs
resource "azurerm_eventhub_namespace_authorization_rule" "authorization" {
  provider            = azurerm.sub_provider
  name                = var.shared_access_policy
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = azurerm_resource_group.resource_group.name
  listen              = true
  send                = true
  manage              = true
}


#Export Diagnostic Settings on Activity Logs deploy to forward Itaudev-SecOps Subscription logs to Event hubs (We need to add the others subscriptions, it's only a test)
resource "azurerm_monitor_diagnostic_setting" "diag-setting" {
  provider                       = azurerm.sub_provider
  name                           = var.monitor_diagnostic_setting_name
  target_resource_id             = "/subscriptions/${var.subscription_id}"
  eventhub_name                  = azurerm_eventhub.eventhub_resource.name
  eventhub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.authorization.id
  dynamic "log" {
    for_each = var.log_categories
    content {
      category = log.value
      enabled  = true
    }
  }
}

#Private Endpoint deploy on itaudev-sbx-networking-001 Subscription linked with vnet-itaudev-sbx-networking-001-0001/ItauToAzure_PrivateEndpoints and Event Hubs
resource "azurerm_private_endpoint" "private_endpoint" {
  provider            = azurerm.networking_provider
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.network_rg_name
  subnet_id           = var.subnet_id
  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = azurerm_eventhub_namespace.eventhub_namespace.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }
}
