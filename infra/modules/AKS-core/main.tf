resource "null_resource" "subscription" {

  triggers = {
    "subscription" = var.subscription_id
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "${var.subscription_id}"
    EOT
  }
}

module "resource_group" {
  source = "../resource-group"

  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }

  subscription_id = var.subscription_id
  resource_groups = var.resource_groups
}



module "managed_identity" {
  source = "../managed-identity"
  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }
  managed_identity = var.managed_identity
  depends_on = [ module.resource_group ]
  }

  module "rbac" {
    source = "../rbac-roles"
     providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
    }
    vnet_id = module.subnet.vnet_ids[0]
    dns_id = module.aks1.id[0]
    managed_identity_id =  module.managed_identity.principal_id[0]
  }
module "route_table" {
  source = "../route-table"
  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }

  route_tables =  var.route_tables
  aks_subnet = module.subnet.subnet_ids[0]
  depends_on = [
    module.resource_group,
    module.subnet
  ]
}

module "network_security_group" {
  source = "../network-security-group"

  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }

  subscription_id         = var.subscription_id
  network_security_groups = var.network_security_groups

  depends_on = [
    module.resource_group.resource_group
  ]
}

module "subnet" {
  source = "../subnet"
  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }
  subscription_id                            = var.subscription_id
  virtual_networks                           = var.virtual_networks
  subnets                                    = var.subnets
  subnet_network_security_group_associations = var.subnet_network_security_group_associations
  depends_on = [
    module.resource_group, module.managed_identity
  ]
}
module "aks1" {
  source     = "../azure kubernetes"
  providers = {
    azurerm              = azurerm
    azurerm.sub_provider = azurerm.sub_provider
  }
  depends_on = [
    module.subnet,module.resource_group
    ]
  private_dns_zone                                 = var.private_dns_zone
  aks_clusters                                     = var.aks_clusters
  aks_subnet                                       = module.subnet.subnet_ids[0]
  managed_identity                                 = module.managed_identity.id[0]
  aci_connector_linux                              = var.aci_connector_linux
  auto_scaler_profile                              = var.auto_scaler_profile
  maintenance_window                               = var.maintenance_window
  linux_profile                                    = var.linux_profile
  network_profile                                  = var.network_profile
  azure_active_directory_role_based_access_control = var.azure_active_directory_role_based_access_control

}


