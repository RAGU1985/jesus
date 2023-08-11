locals {
  group_object_id = "def4e877-7b6f-42ef-9845-2acf47a7be56"
  subscription = {
    name                    = "itaudev-sbx-poc-agentmulticloud"
    alias                   = "itaudev-sbx-poc-agentmulticloud"
    workload                = "Production"
    management_group_id     = "mg-itaudev-sandbox"
    tags = {
      ApplicationName       = "Poc Agent MultiCloud"                       #mandatory
      ApproverName          = "Daniel Matos Lima"                          #mandatory
      CostCenter            = "341-43082"                                  #mandatory
      CreatedWith           = "DevOps"                                     #mandatory
      Environment           = "dev"                                        #mandatory
      OwnerName             = "eduardo.a.goncalves@itau-unibanco.com.br"   #mandatory
      RequesterName         = "Eduardo Goncalves"                          #mandatory
      StartDateOfTheProject = "02/06/2023"                                 #mandatory
      NotificationEmail     = "eduardo.a.goncalves@itau-unibanco.com.br"   #mandatory
      ProductOwnerEmail     = "juliano.affonso@itau-unibanco.com.br"       #mandatory
      Sigla                 = "XB2"                                        #mandatory
      Person                = "Eduardo Goncalves"                          #mandatory
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
