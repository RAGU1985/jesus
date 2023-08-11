include {
  path = find_in_parent_folders()
}

dependency "subscription" {
  config_path = "../sub-sbx-001"

  mock_outputs_allowed_terraform_commands = ["plan", "validate", "output", "show"]
  mock_outputs = {
    subscription_id = "eeebbc0b-92b0-491f-aed6-47940c643d51"
  }
}

# When using this terragrunt config, terragrunt will generate the file "provider.tf" with the aws provider block before
# calling to terraform. Note that this will overwrite the `provider.tf` file if it already exists.
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

# locals {
#   this_module_name = "${basename(get_terragrunt_dir())}"
#   # Load environment-level variables from files in parents folders
#   env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
#   # Extract common variables for reuse
#   location = local.env_vars.locals.location
#   env      = local.env_vars.locals.env_name
#   mghead   = local.env_vars.locals.mghead
#   provider_version = "3.52.0"
#   net_rg_name = "rg-net-${local.mghead}-sbx-${local.location}-001"
#   shared_rg_name = "rg-shared-${local.location}-${local.env}-001"
#   tags = {
#     ApplicationName       = "Compass Data"                               #mandatory
#     ApproverName          = "Daniel Matos Lima"                          #mandatory
#     CostCenter            = "341-43082"                                  #mandatory
#     CreatedWith           = "DevOps"                                     #mandatory
#     Environment           = "dev"                                        #mandatory
#     OwnerName             = "thiago.santos-freitas@itau-unibanco.com.br" #mandatory
#     RequesterName         = "Thiago dos Santos Freitas"                  #mandatory
#     StartDateOfTheProject = "24/05/2023"                                 #mandatory
#     NotificationEmail     = "redmond-camadazero@correio.itau.com.br"     #mandatory
#     ProductOwnerEmail     = "daniel.matos-lima@itau-unibanco.com.br"     #mandatory
#     Sigla                 = "JP7"                                        #mandatory
#     Person                = "Thiago dos Santos Freitas"                  #mandatory
#   }
#   virtual_networks = {
#     virtualnetwork1 = {
#       name                 = "vnet-sandbox-brazilsouth-003"
#       address_space        = ["10.0.0.0/16"]
#       rg_name              = local.net_rg_name
#       dns_servers          = null
#       ddos_protection_plan = null
#     }
#     virtualnetwork2 = {
#       name                 = "vnet-sandbox-brazilsouth-004"
#       address_space        = ["10.1.0.0/16"]
#       rg_name              = local.net_rg_name
#       dns_servers          = null
#       ddos_protection_plan = null
#     }
#     virtualnetwork3 = {
#       name                 = "vnet-dns-brazilsouth-sandboux-001"
#       address_space        = ["10.2.0.0/16"]
#       rg_name              = local.net_rg_name
#       dns_servers          = null
#       ddos_protection_plan = null
#     }
#     virtualnetwork4 = {
#       name                 = "vnet-shared-${local.location}-${local.env}-001"
#       address_space        = ["10.0.0.0/18"]
#       rg_name              = local.shared_rg_name
#       dns_servers          = null
#       ddos_protection_plan = null
#     }
#   }
#   subnets = {
#     subnet1 = {
#       vnet_key          = "virtualnetwork1"
#       vnet_name         = null #jstartvmssfirst
#       name              = "snet-firewall-brazilsouth-001"
#       rg_name           = local.net_rg_name
#       address_prefixes  = ["10.0.0.0/26"]
#       service_endpoints = []
#       pe_enable         = false
#       delegation        = []
#     },
#     subnet2 = {
#       vnet_key          = "virtualnetwork1"
#       vnet_name         = null #jstartvmssfirst
#       name              = "snet-bastion-brazilsouth-001"
#       rg_name           = local.net_rg_name
#       address_prefixes  = ["10.0.0.64/26"]
#       service_endpoints = []
#       pe_enable         = false
#       delegation        = []
#     },
#     subnet3 = {
#       vnet_key          = "virtualnetwork1"
#       vnet_name         = null #jstartvmssfirst
#       name              = "snet-mgmt-brazilsouth-001"
#       rg_name           = local.net_rg_name
#       address_prefixes  = ["10.0.0.128/26"]
#       service_endpoints = []
#       pe_enable         = false
#       delegation        = []
#     },
#     subnet4 = {
#       vnet_key          = "virtualnetwork2"
#       vnet_name         = null #jstartvmssfirst
#       name              = "snet-aks-brazilsouth-001"
#       rg_name           = local.net_rg_name
#       address_prefixes  = ["10.1.0.0/24"]
#       service_endpoints = []
#       pe_enable         = false
#       delegation        = []
#     },
#     subnet5 = {
#       vnet_key          = "virtualnetwork3"
#       vnet_name         = null #jstartvmssfirst
#       name              = "snet-hub-dns-brazilsouth-001"
#       rg_name           = local.net_rg_name
#       address_prefixes  = ["10.2.0.128/24"]
#       service_endpoints = []
#       pe_enable         = false
#       delegation        = []
#     },
#     subnet6 = {
#       vnet_key          = "virtualnetwork4"
#       vnet_name         = null #jstartvmssfirst
#       name              = "snet-shared-${local.location}-${local.env}-001"
#       rg_name           = local.shared_rg_name
#       address_prefixes  = ["10.0.0.0/19"]
#       service_endpoints = []
#       pe_enable         = false
#       delegation        = []
#     },
#   }

#   vnet_peering = {
#     akstobastion = {
#       destination_vnet_name                 = local.virtual_networks.virtualnetwork1.name
#       destination_vnet_rg                   = local.net_rg_name #"[__resource_group_name__]"
#       remote_destination_virtual_network_id = "/subscriptions/subscriptionidplaceholder/resourceGroups/${local.net_rg_name}/providers/Microsoft.Network/virtualNetworks/${local.virtual_networks.virtualnetwork1.name}"
#       source_vnet_name                      = local.virtual_networks.virtualnetwork2.name
#       source_vnet_rg                        = local.net_rg_name
#       allow_forwarded_traffic               = true
#       allow_virtual_network_access          = true
#       allow_gateway_transit                 = false
#       use_remote_gateways                   = false
#     }
#     bastiontoaks = {
#       destination_vnet_name                 = local.virtual_networks.virtualnetwork2.name
#       destination_vnet_rg                   = local.net_rg_name #"[__resource_group_name__]"
#       remote_destination_virtual_network_id = "/subscriptions/subscriptionidplaceholder/resourceGroups/${local.net_rg_name}/providers/Microsoft.Network/virtualNetworks/${local.virtual_networks.virtualnetwork2.name}"
#       source_vnet_name                      = local.virtual_networks.virtualnetwork1.name
#       source_vnet_rg                        = local.net_rg_name
#       allow_forwarded_traffic               = true
#       allow_virtual_network_access          = true
#       allow_gateway_transit                 = false
#       use_remote_gateways                   = false
#     }
#   }
#   network_security_groups = {
#     nsg1 = {
#       name                                  = "nsg-allowbastion-001"
#       rg_name                               = local.net_rg_name
#       tags                                  = null
#       subnet_name                           = "snet-aks-brazilsouth-001"
#       subnet_key                            = "subnet4"
#       networking_resource_group             = "${local.net_rg_name}"
#       security_rules = [
#         {
#           name                              = "BastionInbound"
#           description                       = "NSG"
#           priority                          = 100
#           direction                         = "Inbound"
#           access                            = "Allow"
#           protocol                          = "Tcp"
#           source_port_range                 = "*"
#           source_address_prefix             = "10.0.0.0/26"
#           destination_port_ranges           = ["3389", "22"]
#           destination_address_prefix        = "*"
#           source_port_ranges                = null
#           destination_port_range            = null
#           source_address_prefixes           = null
#           destination_address_prefixes      = null
#         },
#       ]
#     },
#     nsg2 = {
#       name                                  = "nsg-hub-dns-brazilsouth-003"
#       rg_name                               = local.net_rg_name
#       tags                                  = null
#       subnet_name                           = "snet-hub-dns-brazilsouth-001"
#       subnet_key                            = "subnet4"
#       networking_resource_group             = "${local.net_rg_name}"
#       security_rules = [
#         {
#           name                              = "DnsInbound"
#           description                       = "NSG"
#           priority                          = 100
#           direction                         = "Inbound"
#           access                            = "Allow"
#           protocol                          = "Tcp"
#           source_port_range                 = "*"
#           source_address_prefix             = "10.2.0.0/25"
#           destination_port_ranges           = ["3389", "22"]
#           destination_address_prefix        = "*"
#           source_port_ranges                = null
#           destination_port_range            = null
#           source_address_prefixes           = null
#           destination_address_prefixes      = null
#         },
#       ]
#     },
#     nsg3 = {
#       name                                  = "nsg-shared-${local.location}-${local.env}-001"
#       rg_name                               = local.shared_rg_name
#       tags                                  = null
#       subnet_name                           = local.subnets.subnet6.name
#       security_rules = [
#         {
#           name                              = "SharedInbound"
#           description                       = "NSG"
#           priority                          = 100
#           direction                         = "Inbound"
#           access                            = "Allow"
#           protocol                          = "Tcp"
#           source_port_range                 = "*"
#           source_address_prefix             = "10.0.0.0/19"
#           destination_port_ranges           = ["3389", "22"]
#           destination_address_prefix        = "*"
#           source_port_ranges                = null
#           destination_port_range            = null
#           source_address_prefixes           = null
#           destination_address_prefixes      = null
#         },
#       ]
#     },
#   }

#   pdz_name    = "pdz-hub-brasilsouth-001"
#   pdr_name    = "prn-hub-brasilsouth-001"
#   pdv_name    = "pe-hub-dns-brasilsouth-001"
#   pdr_vn_id   = "/subscriptions/subscriptionidplaceholder/resourceGroups/${local.net_rg_name}/providers/Microsoft.Network/virtualNetworks/${local.virtual_networks.virtualnetwork3.name}"

# }

# terraform {
#   source = "${get_parent_terragrunt_dir()}/modules//sandbox-subscription"
# }

inputs = {
    subscription_id                 = dependency.subscription.outputs.subscription_id
    net_rg_name                     = local.net_rg_name
    net_location                    = local.location
    environment                     = local.env
    virtual_networks                = local.virtual_networks
    subnets                         = local.subnets
    tags                            = local.tags
    vnet_peering                    = local.vnet_peering
    network_security_groups         = local.network_security_groups
    virtual_network_name            = local.virtual_networks.virtualnetwork2.name
    private_dns_zone_name           = local.pdz_name
    private_dns_resolver_name       = local.pdr_name
    private_dns_virtual_link_name   = local.pdv_name
    virtual_network_id_for_dns      = local.pdr_vn_id
}
