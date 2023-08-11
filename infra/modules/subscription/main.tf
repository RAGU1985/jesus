data "azurerm_management_group" "mg" {
  name = var.subscription["management_group_id"]
}

resource "azurerm_subscription" "sub" {
  subscription_name = var.subscription["name"]
  alias             = var.subscription["alias"]
  billing_scope_id  = var.subscription_billing_scope
  workload          = var.subscription["workload"]
  tags              = var.subscription["tags"]

  # This provisioner requires az cli to be installed and logged in.
  provisioner "local-exec" {
    when       = destroy
    command    = "az resource delete --ids /subscriptions/${self.subscription_id}/resourceGroups/NetworkWatcherRG"
    on_failure = continue
  }
}

resource "azurerm_management_group_subscription_association" "add_subscription_to_mg" {
  management_group_id = data.azurerm_management_group.mg.id
  subscription_id     = "/subscriptions/${azurerm_subscription.sub.subscription_id}"
  depends_on          = [azurerm_subscription.sub]
}

resource "azurerm_role_assignment" "assoc_group_id" {
  count                = var.add_group_object_id ? 1 : 0
  scope                = "/subscriptions/${azurerm_subscription.sub.subscription_id}"
  role_definition_name = var.role_definition_name
  principal_id         = var.group_object_id
}