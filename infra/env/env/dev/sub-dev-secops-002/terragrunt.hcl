locals {
  # group_object_id could be identified by running the following cmd
  # az ad group show --group AD_GROUP_NAME -o json --query '.id'
  group_object_id = "58c65bf0-a60a-4d13-90f0-1502a6e16ec4"
  subscription = {
    name                = "itaudev-secops-002"
    alias               = "itaudev-secops-002"
    workload            = "Production"
    management_group_id = "mg-itaudev-secops"
    tags = {
      ApplicationName       = "Itau Sec Operations subscription"           #mandatory
      ApproverName          = "Daniel Matos Lima"                          #mandatory
      CostCenter            = "341-43082"                                  #mandatory
      CreatedWith           = "DevOps"                                     #mandatory
      Environment           = "prod"                                       #mandatory
      OwnerName             = "daniel.matos-lima@itau-unibanco.com.br"     #mandatory
      RequesterName         = "Daniel Matos Lima"                          #mandatory
      StartDateOfTheProject = "11/07/2023"                                 #mandatory
      NotificationEmail     = "daniel.matos-lima@itau-unibanco.com.br"     #mandatory
      ProductOwnerEmail     = "juliano.affonso@itau-unibanco.com.br"       #mandatory
      Sigla                 = "JB7"                                        #mandatory
      Person                = "Daniel Matos Lima"                          #mandatory
    }
  }
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules//subscription"
}

inputs = {
  subscription = local.subscription
  add_group_object_id = true
  group_object_id = local.group_object_id
  role_definition_name  = "Azure Event Hubs Data Receiver"
}