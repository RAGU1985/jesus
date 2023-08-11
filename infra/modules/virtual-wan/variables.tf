variable "subscription_id" {
  type        = string
  description = "Subscription id to echo"
}

variable "virtual_wan_id_template" {
  type    = string
  default = "/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.Network/virtualWans/virtualWanName"
}

variable "virtual_hub_id_template" {
  type    = string
  default = "/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.Network/virtualHubs/virtualHubName"
}

variable "virtual_network_id_template" {
  type    = string
  default = "/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.Network/virtualNetworks/virtualNetworkName"
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