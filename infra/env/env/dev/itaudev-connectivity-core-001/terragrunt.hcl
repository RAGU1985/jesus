locals {
  group_object_id = "6867e0c2-64ae-4702-a0e6-a7584d719011"
  subscription = {
    name                    = "itaudev-connectivity-core-001"
    alias                   = "itaudev-connectivity-core-001"
    workload                = "Production"
    management_group_id     = "mg-itaudev-connectivity"
    tags = {
      ApplicationName       = "itaudev-connectivity-core-001"              #mandatory
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