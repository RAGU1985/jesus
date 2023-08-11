variable "subscription_id" {
  type        = string
  description = "Subscription id to echo"
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
