
# Datalake service account
resource "yandex_iam_service_account" "sa-dataproc" {
  name        = var.sa_name
  description = "service account to manage Dataproc Cluster"
}

resource "yandex_iam_service_account_static_access_key" "sa-dataproc-key" {
  description = "Dataproc Cluster Service accaunt access to datalake bucket"  
  service_account_id = yandex_iam_service_account.sa-dataproc.id
}

// editr required in order to create bucket 
// and for autoscaling
// or following grants must be provided: compute.admin dataproc.agent  dns.editor iam.serviceAccounts.user
// mdb.admin mdb.dataproc.agent  monitoring.viewer storage.editor storage.uploader
// storage.viewer vpc.user
resource "yandex_resourcemanager_folder_iam_binding" "bucket-creator" {
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa-dataproc.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "dataproc" {
  folder_id = var.folder_id
  role      = "mdb.dataproc.agent"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa-dataproc.id}",
  ]
}