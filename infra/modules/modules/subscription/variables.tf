##### Subscription #######

variable "subscription" {
  type = object({
    name                = string
    alias               = string
    workload            = string
    management_group_id = string
    tags                = map(string)
  })
}

variable "subscription_billing_scope" {
  type        = string
  default     = "/providers/Microsoft.Billing/billingAccounts/6435466/enrollmentAccounts/337304"
  description = <<DESCRIPTION
The billing scope for the new subscription alias.
A valid billing scope starts with `/providers/Microsoft.Billing/billingAccounts/` and is case sensitive.
E.g.
- For CustomerLed and FieldLed, e.g. MCA - `/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}`
- For PartnerLed, e.g. MPA - `/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/customers/{customerName}`
- For Legacy EA - `/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/enrollmentAccounts/{enrollmentAccountName}`
You may also supply an empty string if you do not want to create a new subscription alias.
In this scenario, `subscription_enabled` should be set to `false` and `subscription_id` must be supplied.
DESCRIPTION
  validation {
    condition     = can(regex("^$|^/providers/Microsoft.Billing/billingAccounts/.*$", var.subscription_billing_scope))
    error_message = "A valid billing scope starts with /providers/Microsoft.Billing/billingAccounts/ and is case sensitive."
  }
}

variable "add_group_object_id" {
  type    = bool
  default = false
}

variable "group_object_id" {
  type = string
}

variable "role_definition_name" {
  type    = string
  default = "Contributor"
}