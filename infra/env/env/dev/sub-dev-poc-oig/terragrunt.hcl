locals {
  # group_object_id could be identified by running the following cmd
  # az ad group show --group AD_GROUP_NAME -o json --query '.id'
  group_object_id = "de411d81-0736-4153-9e87-453323314aa0"
  subscription = {
    name                    = "itaudev-dev-poc-oig"
    alias                   = "itaudev-dev-poc-oig"
    workload                = "Production"
    management_group_id     = "mg-itaudev-dev"
    tags = {
      ApplicationName       = "Poc EQ3/OIG"                             #mandatory
      ApproverName          = "Daniel Matos Lima"                       #mandatory
      CostCenter            = "341-43082"                               #mandatory
      CreatedWith           = "DevOps"                                  #mandatory
      Environment           = "dev"                                     #mandatory
      OwnerName             = "luis.crespo@itau-unibanco.com.br"        #mandatory
      RequesterName         = "Luis Felipe Crespo"                      #mandatory
      StartDateOfTheProject = "21/06/2023"                              #mandatory
      NotificationEmail     = "luis.crespo@itau-unibanco.com.br"        #mandatory
      ProductOwnerEmail     = "juliano.affonso@itau-unibanco.com.br"    #mandatory
      Sigla                 = "EQ3"                                     #mandatory
      Person                = "Luis Felipe Crespo"                      #mandatory
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
  add_group_object_id       = true
  role_definition_name      = "Itau-ContributorWithRBACPermission"
  group_object_id           = local.group_object_id
  subscription              = local.subscription
}
