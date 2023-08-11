provider "azurerm" {
  alias           = "networking_provider"
  subscription_id = var.networking_subscription_id
  features {}
}
