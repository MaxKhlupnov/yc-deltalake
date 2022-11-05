### Locals
locals {
  bucket_name    = var.create_bucket ? yandex_storage_bucket.datalake[0].bucket : var.bucket_name
}


resource "yandex_dataproc_cluster" "dataproc-main" {
    depends_on =   [yandex_resourcemanager_folder_iam_binding.dataproc]
    bucket      =  local.bucket_name
    description =  "Datalake main dataproc cluster"
    name        =  var.dataproc_cluster_name
    labels      =  var.labels

    service_account_id = yandex_iam_service_account.sa-dataproc.id
    zone_id            = var.dataproc_cluster_subnet.zone

    cluster_config {
            # For datalake we need only spark compute and hive metastore
            # LIVY and ZEPPELIN - added for developers access
            # "HDFS", "TEZ", "MAPREDUCE" - removed

            hadoop {
            services = ["YARN", "SPARK", "HIVE", "LIVY", "ZEPPELIN"] 
            properties = {
                "yarn:yarn.resourcemanager.am.max-attempts" = 5,
                "core:fs.s3a.committer.name": "directory",
                "core:mapreduce.outputcommitter.factory.scheme.s3a" : "org.apache.hadoop.fs.s3a.commit.S3ACommitterFactory",
                "spark:spark.sql.sources.commitProtocolClass" : "org.apache.spark.internal.io.cloud.PathOutputCommitProtocol",
                "spark:spark.sql.parquet.output.committer.class" : "org.apache.spark.internal.io.cloud.BindingParquetOutputCommitter",
                "spark:fs.s3a.aws.credentials.provider" : "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider",
                "spark:fs.s3a.committer.staging.conflict-mode" :	"append",
                "spark:fs.s3a.committer.staging.tmp.path" :	"tmp/staging",
                "spark:fs.s3a.committer.staging.unique-filenames" :	"true",
                "spark:fs.s3a.fast.upload" :	"true", # upload directly from memory
                "spark:fs.s3a.committer.abort.pending.uploads" :	"true",
                "spark:spark.hadoop.parquet.enable.summary-metadata" : "false", 
                "spark:spark.scheduler.mode" : "FAIR",                
                #"dataproc:hive.thrift.impl" : "spark",
                "spark:spark.dynamicAllocation.enabled" : "true",
                "spark:spark.driver.memory" : "4g",
                "spark:spark.executor.memory" : "16g", 
                "spark:spark.executor.cores": "4"
            }
            ssh_public_keys = [
            file(var.public_key_file_path)]
            }

            subcluster_spec {
                name = "main"
                role = "MASTERNODE"
                resources {
                    resource_preset_id = var.resource_preset_id_master
                    disk_type_id       = var.master_disk_type_id
                    disk_size          = var.disk_size_master
                }
                subnet_id   =  var.dataproc_cluster_subnet.id
                hosts_count = 1
            }

            subcluster_spec {
                name = "compute_autoscaling"
                role = "COMPUTENODE"
                resources {
                    resource_preset_id = var.resource_preset_id_compute_node
                    disk_type_id       = var.compute_disk_type_id
                    disk_size          = var.disk_size_compute
                }
                subnet_id   = var.dataproc_cluster_subnet.id
                hosts_count = 1     
                autoscaling_config {
                    max_hosts_count = 4
                    measurement_duration = 60
                    warmup_duration = 60
                    stabilization_duration = 120
                    preemptible = false
                    decommission_timeout = 60
                }
            }
    }
}
