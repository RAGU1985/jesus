variable "subscription_id" {
  type        = string
  description = "Subscription id to echo"
}

variable "resource_groups" {
  type = map(object({
    location = string
    name     = string
  }))
  description = "Specifies the map of objects for a resource group"
  default     = {}
}

variable "network_security_groups" {
  type = map(object({
    location            = string
    name                = string
    resource_group_name = string

    security_rules = list(object({
      name                         = string
      description                  = string
      protocol                     = string
      direction                    = string
      access                       = string
      priority                     = number
      source_address_prefix        = string
      source_address_prefixes      = list(string)
      destination_address_prefix   = string
      destination_address_prefixes = list(string)
      source_port_range            = string
      source_port_ranges           = list(string)
      destination_port_range       = string
      destination_port_ranges      = list(string)
    }))
  }))
  description = "Specifies the map of objects for a network security group"
  default     = {}
}

variable "virtual_networks" {
  type = map(object({
    address_space       = list(string)
    location            = string
    name                = string
    resource_group_name = string
  }))
  description = "Specifies the map of objects for a virtual network"
  default     = {}
}

variable "subnets" {
  type = map(object({
    address_prefixes                          = list(string)
    name                                      = string
    private_endpoint_network_policies_enabled = bool
    resource_group_name                       = string
    virtual_network_name                      = string
    service_endpoints                         = list(string)
    delegation = list(object({
      name = string
      service_delegation = list(object({
        actions = list(string)
        name    = string
      }))
    }))
  }))
  description = "Specifies the map of objects for a subnet"
  default     = {}
}

variable "virtual_network_peerings" {
  type = map(object({
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    allow_virtual_network_access = bool
    name                         = string
    resource_group_name          = string
    use_remote_gateways          = bool
    virtual_network_name         = string
  }))
  description = "Specifies the map of objects for virtual network peering."
  default     = {}
}

variable "subnet_network_security_group_associations" {
  type = map(object({
    network_security_group_name = string
    resource_group_name         = string
    subnet_name                 = string
    virtual_network_name        = string
  }))
  description = "Specifies the map of objects for a subnet network security group association."
  default     = {}
}

variable "virtual_wans" {
  type = map(object({
    location            = string
    name                = string
    resource_group_name = string
  }))
  description = "Specifies the map of objects for a virtual wan group"
  default     = {}
}

variable "virtual_hubs" {
  type = map(object({
    address_prefix      = string
    location            = string
    name                = string
    resource_group_name = string
    sku                 = string
    virtual_wan_name    = string
  }))
  description = "Specifies the map of objects for a virtual hub"
  default     = {}
}

variable "express_route_gateways" {
  type = map(object({
    location            = string
    name                = string
    resource_group_name = string
    scale_units         = number
    virtual_hub_name    = string
  }))
  description = "Specifies the map of objects for an express route gateway"
  default     = {}
}

variable "virtual_hub_route_tables" {
  type = map(object({
    labels              = set(string)
    name                = string
    resource_group_name = string
    virtual_hub_name    = string
  }))
  description = "Specifies the map of objects for an virtual hub route table"
  default     = {}
}

variable "virtual_hub_connections" {
  type = map(object({
    internet_security_enabled   = bool
    name                        = string
    remote_resource_group_name  = string
    remote_virtual_network_name = string
    resource_group_name         = string
    virtual_hub_name            = string
  }))
  description = "Specifies the map of objects for an virtual hub connection"
  default     = {}
}

variable "private_dns_resolvers" {
  type = map(object({
    location             = string
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
  }))
  description = "Specifies the map of objects for a private dns resolver"
  default     = {}
}

variable "private_dns_resolver_inbound_endpoints" {
  type = map(object({
    location                  = string
    name                      = string
    private_dns_resolver_name = string
    resource_group_name       = string
    ip_configurations = list(object({
      virtual_network_name = string
      resource_group_name  = string
      subnet_name          = string
    }))
  }))
  description = "Specifies the map of objects for a private dns resolver inbound endpoint"
  default     = {}
}

variable "private_dns_zones" {
  type = map(object({
    name                = string
    resource_group_name = string
  }))
  description = "Specifies the map of objects for a private dns zone"
  default     = {}
}

variable "private_dns_zone_virtual_network_links" {
  type = map(object({
    name                  = string
    private_dns_zone_name = string
    resource_group_name   = string
    virtual_network_name  = string
  }))
  description = "Specifies the map of objects for a private dns zone virtual network link"
  default     = {}
}