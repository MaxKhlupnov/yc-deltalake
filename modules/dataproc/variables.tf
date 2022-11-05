variable "network_id" {
  type = string
}

variable "folder_id" {
  type        = string
  description = "Folder-ID where the resources will be created"
}

variable "cluster_name" {
  type        = string
  description = "Unique for the name of a dataproc cluster"
}

variable "dataproc_cluster_subnet" {
    description = "CIDR of dataproc cluster subnet"
    type = object(
    {
      id             = string   
      zone           = string
    }
  )
}


variable "create_bucket" {
  type        = bool
  default     = true
  description = "Create Object Storage bucket or not. If false existing bucket is required"
}

variable "dataproc_cluster_name" {
  type        = string
  default     = "dataproc-main"
  description = "This name will be used for the cluster"
}


variable "bucket_name" {
  type        = string
  default     = "my-datalake"
  description = "This name will be used if we'll crete bucket"
}

variable "sa_name" {
  type        = string
  default     = "sa-datalake"
  description = "This name will be used for cluster service account"
}


variable "public_key_file_path" {
  type        = string
  description = "path to file with your public key to access master via ssh"
}            

variable "description" {
  type    = string
  default = null
}

variable "security_group_ids" {
  type = list(string)
  default = null
  description = "A set of ids of security groups assigned to hosts of the cluster"
}

variable "resource_preset_id_master" {
  type        = string
  default     = "s3-c4-m16"
  description = "Id of a dataproc master preset which means count of vCPUs and amount of RAM per host"
}

variable "resource_preset_id_compute_node" {
  type        = string
  default     = "s3-c8-m32"
  description = "Id of a cluster compute node preset which means count of vCPUs and amount of RAM per host"
}

variable "disk_size_master" {
  type        = number
  default     = 64
  description = "Disk size in GiB"
}

variable "disk_size_compute" {
  type        = number
  default     = 186                 # must be a multiple of 93 for NRD
  description = "Disk size in GiB"
}

variable "master_disk_type_id" {
  type        = string
  default     = "network-ssd"
  description = "Disk type: 'network-ssd', 'network-hdd', 'network-ssd-nonreplicated'"
}

variable "compute_disk_type_id" {
  type        = string
  default     = "network-ssd-nonreplicated"
  description = "Disk type: 'network-ssd', 'network-hdd', 'network-ssd-nonreplicated'"
}

variable "database_version" {
  type        = string
  default     = "2.0"
  description = "Version of ClickHouse"
}

variable "labels" {
  type = map
  default = {
    deployment = "terraform"
  }
}
