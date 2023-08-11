include {
  path = find_in_parent_folders()
}

dependency "subscription" {
  config_path = "../sub-sbx-test-networking"

  mock_outputs_allowed_terraform_commands = ["plan", "validate", "output", "show"]
  mock_outputs = {
    subscription_id = "ca52de3f-11d3-4fcb-94d5-e3c55cbbad6e"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "azurerm" {
  alias           = "sub_provider"
  subscription_id = "${dependency.subscription.outputs.subscription_id}"
  features {}
}
EOF
}
locals {
  this_module_name  = "${basename(get_terragrunt_dir())}"
  env_vars          = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  location          = local.env_vars.locals.location
  env_name          = local.env_vars.locals.env_name
  provider_version  = "3.52.0"

  resource_groups = {
    resource_group_aks = {
        location    = local.location
        name        = "rg-aks-${local.location}-${local.env_name}-001"
    }
  }
  network_security_groups = {
    nsg_dns = {
        location            = local.location
        name                = "nsg-aks-${local.location}-${local.env_name}-001"
        resource_group_name = local.resource_groups.resource_group_aks.name
        security_rules      = []
    }
  }
  managed_identity = {
    identity = {
        resource_group_name     = local.resource_groups.resource_group_aks.name
        name                    = "aks-identity-${local.location}-${local.env_name}-001" 
        location                = local.location
    }
  }

   private_dns_zone = {
    dns = {
        name                = "privatelink.azurecr.io"
        resource_group_name = local.resource_groups.resource_group_aks.name
    }
  }

  route_tables = {
    udr = {

    name = "udr-aks-${local.location}-${local.env_name}-001"
    resource_group_name = local.resource_groups.resource_group_aks.name
    location            = local.location
    disable_bgp_route_propagation = "true"
   routes = [{
      name                   = "palo_alto_udr"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.128.201.38"
   }]

}

}
   virtual_networks = {
    vnet = {
        name                = "vnet-itaudev-sbx-test-networking-001"
        resource_group_name = local.resource_groups.resource_group_aks.name
    }
  }

  subnets = {
    snet_aks1 = {
        address_prefixes                          = ["10.129.24.00/26"]
        name                                      = "snet-aks-${local.location}-${local.env_name}-001"
        private_endpoint_network_policies_enabled = false
        resource_group_name                       = local.resource_groups.resource_group_aks.name
        service_endpoints                         = []
        virtual_network_name                      = local.virtual_networks.vnet.name
        delegation           = [{
            name        = "Microsoft.Network.dnsResolvers"
            service_delegation = [{
                actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
                name    = "Microsoft.Network/dnsResolvers"
            }]
        }]
    }

  }


 aks_clusters = {

  "aks1" = {
    name                = "aks-itau-${local.location}-${local.env_name}-001"
    resource_group_name = local.resource_groups.resource_group_aks.name
    location            = local.location
    dns_prefix          = "dnsprefix-aks-${local.location}-${local.env_name}-001"
    kubernetes_version  = "1.26.3"
    sku_tier            = "Standard"
    node_resource_group = "aks-noderg-${local.location}-${local.env_name}-001"

    aks_default_pool = {
      name                         = "agent pool"
      vm_size                      = "Standard_F16s_V2"
      availability_zones           = [3]
      enable_auto_scaling          = true
      max_pods                     = 30
      os_disk_size_gb              = 128
      os_disk_type                 = "Ephemeral"
      networking_resource_group    = "vnet-aks-${local.location}-${local.env_name}-001"
      enable_host_encryption       = false
      node_count                   = 3
      min_count                    = 3
      max_count                    = 10
      only_critical_addons_enabled = true
    }
  }
}

auto_scaler_profile = {
  expander                    = "random"
  scan_interval               = "10s"
  skip_nodes_with_system_pods = true
}

maintenance_window = null

# linux_profile {
# adminusername = "azureaksadmin"
# }
network_profile = {
  load_balancer_sku     = "standard"
  network_plugin_mode   = "Overlay"
  dns_service_ip        = "10.255.255.10"
  service_cidr          = "10.255.255.0/28"
  network_policy        = "azure"
}

azure_active_directory_role_based_access_control = {
  managed            = true
  azure_rbac_enabled = false
  admin_group_object_ids = [

  ]
}
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules//AKS-core"
}

inputs = {
    subscription_id                         = dependency.subscription.outputs.subscription_id
    resource_groups                         = local.resource_groups
    virtual_networks                        = local.virtual_networks
    subnets                                 = local.subnets
    private_dns_zone                        = local.private_dns_zone
    aks_clusters                            = local.aks_clusters
    route_tables                            = local.route_tables
    managed_identity                        = local.managed_identity
}




