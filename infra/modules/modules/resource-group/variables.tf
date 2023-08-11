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
