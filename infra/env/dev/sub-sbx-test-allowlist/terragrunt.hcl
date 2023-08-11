locals {
  group_object_id = "6867e0c2-64ae-4702-a0e6-a7584d719011"
  subscription = {
    name                = "itaudev-sbx-test-allowlist"
    alias               = "itaudev-sbx-test-allowlist"
    workload            = "Production"
    management_group_id = "mg-itaudev-sandbox"
    tags = {
      ApplicationName       = "Allowlist test"                             #mandatory
      ApproverName          = "Daniel Matos Lima"                          #mandatory
      CostCenter            = "341-43082"                                  #mandatory
      CreatedWith           = "DevOps"                                     #mandatory
      Environment           = "dev"                                        #mandatory
      OwnerName             = "gabriela.obana@itau-unibanco.com.br"        #mandatory
      RequesterName         = "Gabriela Sayuri Reboucas Obana"             #mandatory
      StartDateOfTheProject = "24/07/2023"                                 #mandatory
      NotificationEmail     = "gabriela.obana@itau-unibanco.com.br"        #mandatory
      ProductOwnerEmail     = "juliano.affonso@itau-unibanco.com.br"       #mandatory
      Sigla                 = "JB7"                                        #mandatory
      Person                = "Gabriela Sayuri Reboucas Obana"             #mandatory
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
}
