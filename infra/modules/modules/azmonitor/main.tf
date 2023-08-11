resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                  = var.monitor_diagnostic_setting_name
  target_resource_id    = var.virtual_machine_id
  eventhub_namespace_id = azurerm_eventhub_namespace.eventhub_namespace.id
  eventhub_name         = azurerm_eventhub.eventhub.name
  dynamic "log" {
    for_each = var.log_categories
    content {
      category = log.value
      enabled  = true
    }
  }
}

resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = var.eventhub_namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub" "eventhub" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
  capture_description {
    enabled              = true
    size_limit_in_bytes  = 10485763
    destination_name     = "eventhub-archive"
    storage_account_name = var.storage_account_name
  }
}

resource "azurerm_virtual_machine" "virtual_machine" {
  name                = var.virtual_machine_name
  location            = var.location
  resource_group_name = var.resource_group_name
  # Define other VM settings
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}