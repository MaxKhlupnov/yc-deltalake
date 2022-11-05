# Object storge datalake bucket
resource "yandex_storage_bucket" "datalake" {
 count       = var.create_bucket ? 1 : 0
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.bucket-creator
  ]

  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.sa-dataproc-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-dataproc-key.secret_key
}