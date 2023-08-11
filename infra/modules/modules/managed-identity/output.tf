output "principal_id" {
    value = [for x in azurerm_user_assigned_identity.managed_identity : x.principal_id]
}
output "id" {
    value = [for x in azurerm_user_assigned_identity.managed_identity : x.id]
}