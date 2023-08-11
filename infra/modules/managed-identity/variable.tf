variable "managed_identity" {
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
  }))
}