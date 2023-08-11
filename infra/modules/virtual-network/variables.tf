
variable "subscription_id" {
  type        = string
  description = "Subscription id to echo"
}

variable "network_security_group_id_template" {
  type    = string
  default = "/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.Network/networkSecurityGroups/networkSecurityGroupName"
}

variable "subnet_id_template" {
  type    = string
  default = "/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.Network/virtualNetworks/virtualNetworkName/subnets/subnetName"
}

variable "virtual_network_id_template" {
  type    = string
  default = "/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.Network/virtualNetworks/virtualNetworkName"
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