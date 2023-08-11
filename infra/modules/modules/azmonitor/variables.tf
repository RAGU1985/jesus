variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region location"
  type        = string
}

variable "virtual_machine_id" {
  description = "ID of the virtual machine to monitor"
  type        = string
}

variable "virtual_machine_name" {
  description = "Name of the virtual machine to monitor"
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
  default     = ["ActionGroup", "Administrative"]
}

variable "storage_account_name" {
  description = "Name of the storage account for Event Hub capture"
  type        = string
}