variable "subscription_id" {
  type        = string
  description = "Subscription id to echo"
  default     = "d7caf0f4-7c69-4c4a-af92-3b52493f74ca"
}

variable "resource_groups" {
  type = map(object({
    location = string
    name     = string
  }))
  description = "Specifies the map of objects for a resource group"
  default     = {}
}
