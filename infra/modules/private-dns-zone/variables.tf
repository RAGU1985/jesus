variable "subscription_id" {
  type        = string
  description = "Subscription id to echo"
}

variable "virtual_network_id_template" {
  type    = string
  default = "/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.Network/virtualNetworks/virtualNetworkName"
}

variable "private_dns_resolver_id_template" {
  type    = string
  default = "/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.Network/dnsResolvers/dnsResolverName"
}

variable "subnet_id_template" {
  type    = string
  default = "/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.Network/virtualNetworks/virtualNetworkName/subnets/subnetName"
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

variable "virtual_network_peerings" {
  type = map(object({
    name                      = string
    remote_virtual_network_id = string
    resource_group_name       = string
    use_remote_gateways       = bool
    virtual_network_name      = string
  }))
  description = "Specifies the map of objects for a virtual network peering"
  default     = {}
}