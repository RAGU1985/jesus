provider "azurerm" {
  alias           = "sub_provider"
  subscription_id = var.subscription_id
  features {}
}