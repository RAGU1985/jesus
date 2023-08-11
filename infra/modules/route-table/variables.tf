# - Route Table object

variable "route_tables" {
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    disable_bgp_route_propagation = bool

    routes = list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = string
    }))
  }))
  description = "The route tables with their properties."
  default     = {}
}
variable "aks_subnet" {
  type        = string
}