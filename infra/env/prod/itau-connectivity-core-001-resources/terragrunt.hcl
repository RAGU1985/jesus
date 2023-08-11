include {
  path = find_in_parent_folders()
}

dependency "subscription" {
  config_path = "../itau-connectivity-core-001"

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

locals {
  this_module_name  = "${basename(get_terragrunt_dir())}"
  env_vars          = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  location          = local.env_vars.locals.location
  env_name          = local.env_vars.locals.env_name
  provider_version  = "3.52.0"

  resource_groups = {
    resource_group_dns = {
        location    = local.location
        name        = "rg-dns-${local.location}-${local.env_name}-001"
    }
    resource_group_vwan = {
        location    = local.location
        name        = "rg-vwan-${local.location}-${local.env_name}-001"
    }
  }

  network_security_groups = {
    nsg_dns = {
        location            = local.location
        name                = "nsg-dns-${local.location}-${local.env_name}-001"
        resource_group_name = local.resource_groups.resource_group_dns.name
        security_rules      = []
    }
  }

  virtual_networks = {
    vnet_dns = {
        address_space       = ["10.128.62.0/27"]
        location            = local.location
        name                = "vnet-dns-${local.location}-${local.env_name}-001"
        resource_group_name = local.resource_groups.resource_group_dns.name
    }
  }

  subnets = {
    snet_dns = {
        address_prefixes                          = ["10.128.62.0/28"]
        name                                      = "snet-dns-${local.location}-${local.env_name}-001"
        private_endpoint_network_policies_enabled = false
        resource_group_name                       = local.resource_groups.resource_group_dns.name
        service_endpoints                         = []
        virtual_network_name                      = local.virtual_networks.vnet_dns.name
        delegation           = [{
            name        = "Microsoft.Network.dnsResolvers"
            service_delegation = [{
                actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
                name    = "Microsoft.Network/dnsResolvers"
            }]
        }]
    }
  }

  virtual_wans = {
    vwan = {
        location            = local.location
        name                = "vwan-${local.location}-${local.env_name}-001"
        resource_group_name = local.resource_groups.resource_group_vwan.name
    }
  }

  virtual_hubs = {
    vwan = {
        address_prefix      = "10.128.48.0/23"
        location            = local.location
        name                = "vhub-${local.location}-${local.env_name}-001"
        resource_group_name = local.resource_groups.resource_group_vwan.name
        sku                 = "Standard"
        virtual_wan_name    = local.virtual_wans.vwan.name
    }
  }

  virtual_network_peerings = {
    dns_hub = {
        allow_forwarded_traffic       = true
        allow_gateway_transit         = false
        allow_virtual_network_access  = true
        name                          = "${local.virtual_networks.vnet_dns.name}-to-${local.virtual_hubs.vwan.name}"
        resource_group_name           = local.resource_groups.resource_group_dns.name
        use_remote_gateways           = true
        virtual_network_name          = local.virtual_networks.vnet_dns.name
    }
  }

  express_route_gateways = {
    vwan_hub = {
        location            = local.location
        name                = "erg-${local.location}-${local.env_name}-001"
        resource_group_name = local.resource_groups.resource_group_vwan.name
        scale_units         = 1
        virtual_hub_name    = local.virtual_hubs.vwan.name
    }
  }

  virtual_hub_route_tables = {
    wvan_hub_default = {
        labels              = ["default"]
        name                = "vhub-rt-${local.location}-${local.env_name}-default-001"
        resource_group_name = local.resource_groups.resource_group_vwan.name
        virtual_hub_name    = local.virtual_hubs.vwan.name
    },
    wvan_hub_none = {
        labels              = ["none"]
        name                = "vhub-rt-${local.location}-${local.env_name}-none-001"
        resource_group_name = local.resource_groups.resource_group_vwan.name
        virtual_hub_name    = local.virtual_hubs.vwan.name
    },
    wvan_hub_prod = {
        labels              = ["prod"]
        name                = "vhub-rt-${local.location}-${local.env_name}-001"
        resource_group_name = local.resource_groups.resource_group_vwan.name
        virtual_hub_name    = local.virtual_hubs.vwan.name
    },
    wvan_hub_hom = {
        labels              = ["hom"]
        name                = "vhub-rt-${local.location}-homol-001"
        resource_group_name = local.resource_groups.resource_group_vwan.name
        virtual_hub_name    = local.virtual_hubs.vwan.name
    },
    wvan_hub_dev = {
        labels              = ["dev"]
        name                = "vhub-rt-${local.location}-dev-001"
        resource_group_name = local.resource_groups.resource_group_vwan.name
        virtual_hub_name    = local.virtual_hubs.vwan.name
    },
    wvan_hub_infradev = {
        labels              = ["infradev"]
        name                = "vhub-rt-${local.location}-infradev-001"
        resource_group_name = local.resource_groups.resource_group_vwan.name
        virtual_hub_name    = local.virtual_hubs.vwan.name
    },
  }

  virtual_hub_connections = {
    wan_hub = {
        internet_security_enabled   = true
        name                        = "vnet-dns-${local.location}-${local.env_name}-001-connection-001"
        remote_resource_group_name  = local.resource_groups.resource_group_dns.name
        remote_virtual_network_name = local.virtual_networks.vnet_dns.name
        resource_group_name         = local.resource_groups.resource_group_vwan.name
        virtual_hub_name            = local.virtual_hubs.vwan.name
    }
  }

  private_dns_resolvers = {
    resolver = {
        location                = local.location
        name                    = "prn-dns-${local.location}-${local.env_name}-001"
        resource_group_name     = local.resource_groups.resource_group_dns.name
        virtual_network_name    = local.virtual_networks.vnet_dns.name
    }
  }

  private_dns_resolver_inbound_endpoints = {
    endpoint = {
        location                    = local.location
        name                        = "pe-dns-${local.location}-${local.env_name}-001"
        private_dns_resolver_name   = local.private_dns_resolvers.resolver.name
        resource_group_name         = local.resource_groups.resource_group_dns.name
        ip_configurations           = [{
            virtual_network_name    = local.virtual_networks.vnet_dns.name
            resource_group_name     = local.resource_groups.resource_group_dns.name
            subnet_name             = local.subnets.snet_dns.name
        }]
    }
  }

  private_dns_zones = {
    dns = {
        name                = "${local.env_name}.azure.cloud.ihf"
        resource_group_name = local.resource_groups.resource_group_dns.name
    }
  }

  private_dns_zone_virtual_network_links = {
    dns_link = {
        name                  = "vnet-dns-${local.location}-${local.env_name}-link-001"
        private_dns_zone_name = local.private_dns_zones.dns.name
        resource_group_name   = local.resource_groups.resource_group_dns.name
        virtual_network_name  = local.virtual_networks.vnet_dns.name
    }
  }
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules//connectivity-core"
}

inputs = {
    subscription_id                         = dependency.subscription.outputs.subscription_id
    resource_groups                         = local.resource_groups
    network_security_groups                 = local.network_security_groups
    virtual_networks                        = local.virtual_networks
    subnets                                 = local.subnets
    virtual_wans                            = local.virtual_wans
    virtual_hubs                            = local.virtual_hubs
    virtual_network_peerings                = local.virtual_network_peerings
    express_route_gateways                  = local.express_route_gateways
    virtual_hub_route_tables                = local.virtual_hub_route_tables
    virtual_hub_connections                 = local.virtual_hub_connections
    private_dns_resolvers                   = local.private_dns_resolvers
    private_dns_resolver_inbound_endpoints  = local.private_dns_resolver_inbound_endpoints
    private_dns_zones                       = local.private_dns_zones
    private_dns_zone_virtual_network_links  = local.private_dns_zone_virtual_network_links
}