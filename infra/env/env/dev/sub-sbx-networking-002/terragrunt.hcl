locals {
  # group_object_id could be identified by running the following cmd
  # az ad group show --group AD_GROUP_NAME -o json --query '.id'
  group_object_id = "a7268a7c-ce0a-4c29-8512-d65d0291e8bc"
  subscription = {
    name                    = "itaudev-sbx-networking-002"
    alias                   = "itaudev-sbx-networking-002"
    workload                = "Production"
    management_group_id     = "mg-itaudev-connectivity"
    tags = {
      ApplicationName       = "Test Sandbox Networking"                    #mandatory
      ApproverName          = "Daniel Matos Lima"                          #mandatory
      CostCenter            = "341-43082"                                  #mandatory
      CreatedWith           = "DevOps"                                     #mandatory
      Environment           = "dev"                                        #mandatory
      OwnerName             = "daniel.matos-lima@itau-unibanco.com.br"     #mandatory
      RequesterName         = "Daniel Matos Lima"                          #mandatory
      StartDateOfTheProject = "07/06/2023"                                 #mandatory
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
  subscription              = local.subscription
  add_group_object_id       = true
  group_object_id           = local.group_object_id
}
