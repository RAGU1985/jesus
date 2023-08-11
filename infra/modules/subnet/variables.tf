
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