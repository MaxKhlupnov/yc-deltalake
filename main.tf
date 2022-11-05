module "vpc" {
  source       = "./modules/networking"  
  create_vpc   = true
  network_name = "datalake-network"
  domain_name  = "datalake.smarthive.ru"
  folder_id    =  var.yc_folder_id
  subnets      =  var.datalake_subnets
  labels       =  var.default_labels
}

module "dataproc" {
   source         = "./modules/dataproc"
   network_id     = module.vpc.vpc_id   
   dataproc_cluster_subnet = module.vpc.subnets[var.dataproc_cluster_subnet]
   folder_id      =  var.yc_folder_id
   cluster_name   = var.dataproc_cluster_name
   public_key_file_path = "~/.ssh/id_rsa.pub"
}
