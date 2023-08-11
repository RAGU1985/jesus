include {
  path = find_in_parent_folders()
}

dependency "subscription" {
  config_path = "../sub-dev-secops-002"

  mock_outputs_allowed_terraform_commands = ["plan", "validate", "output", "show"]
  mock_outputs = {
    subscription_id = "eeebbc0b-92b0-491f-aed6-47940c643d51"
  }
}

# When using this terragrunt config, terragrunt will generate the file "provider.tf" with the aws provider block before
# calling to terraform. Note that this will overwrite the `provider.tf` file if it already exists.
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "azurerm" {
  alias           = "sub_provider"
  subscription_id = "${dependency.subscription.outputs.subscription_id}"
  features {}
}
EOF
}

# terraform {
#   source = "${get_parent_terragrunt_dir()}/modules//sandbox-subscription"
# }

#Variables
inputs = {
    subscription_id = dependency.subscription.outputs.subscription_id
    networking_subscription_id = "f1b4aefd-f398-4740-a687-e1ed446e32d3"
    resource_group_name = "rg-siem-dev-001"
    location = "brazilsouth"
    eventhub_namespace_name = "evh-siem-dev-001"
    eventhub_name = "insights-activity-logs"
    shared_access_policy = "RootListenSendSharedAccessKey"
    monitor_diagnostic_setting_name = "diagnostic_setting_logs"
    log_categories = ["Administrative", "Security", "Alert", "Policy"]
    private_endpoint_name = "pe-siem-dev-001"
    subnet_id = "/subscriptions/f1b4aefd-f398-4740-a687-e1ed446e32d3/resourceGroups/rg-network-poc-dev/providers/Microsoft.Network/virtualNetworks/vnet-itaudev-sbx-networking-001-0001/subnets/ItauToAzure_PrivateEndpoints"
    network_rg_name = "rg-network-poc-dev"
    private_service_connection_name = "ps-dev-secops-002"
}