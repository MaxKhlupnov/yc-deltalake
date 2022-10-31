module "vpc" {
  source       = "./modules/networking"  
  create_vpc   = true
  network_name = "datalake-network"
  domain_name  = "datalake.smarthive.ru"
  folder_id    =  var.yc_folder_id
  subnets      =  var.datalake_subnets
  labels =  var.default_labels
}


