variable "subscription_id" {
  type = string
}

variable "networking_subscription_id" {
  type = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region location"
  type        = string
}

variable "eventhub_namespace_name" {
  description = "Name of the Event Hub namespace"
  type        = string
}

variable "eventhub_name" {
  description = "Name of the Event Hub"
  type        = string
}

variable "monitor_diagnostic_setting_name" {
  description = "Name of the monitor diagnostic setting"
  type        = string
}

variable "log_categories" {
  description = "List of log categories to enable"
  type        = list(string)
}

variable "private_endpoint_name" {
  description = "Name of the private endpoint"
  type        = string
}

variable "subnet_id" {
  description = "Number of Subnet ID"
  type        = string
}

variable "shared_access_policy" {
  description = "Shared Access Policies ID"
  type        = string
}

variable "network_rg_name" {
  description = "Resource Group of Networking Subscription"
  type        = string
}

variable "private_service_connection_name" {
  description = "private service connection name"
  type        = string
}