locals {
  group_object_id = "def4e877-7b6f-42ef-9845-2acf47a7be56"
  subscription = {
    name                    = "itaudev-sbx-03"
    alias                   = "itaudev-sbx-03"
    workload                = "Production"
    management_group_id     = "mg-itaudev-sandbox"
    tags = {
      ApplicationName       = "Poc Network topology"                       #mandatory
      ApproverName          = "Daniel Matos Lima"                          #mandatory
      CostCenter            = "341-43082"                                  #mandatory
      CreatedWith           = "DevOps"                                     #mandatory
      Environment           = "dev"                                        #mandatory
      OwnerName             = "thiago.santos-freitas@itau-unibanco.com.br" #mandatory
      RequesterName         = "Thiago dos Santos Freitas"                  #mandatory
      StartDateOfTheProject = "16/05/2023"                                 #mandatory
      NotificationEmail     = "redmond-camadazero@correio.itau.com.br"     #mandatory
      ProductOwnerEmail     = "daniel.matos-lima@itau-unibanco.com.br"     #mandatory
      Sigla                 = "JP7"                                        #mandatory
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
