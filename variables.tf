variable "yc_oauth_token" {
  description = "YC OAuth token"
  default     = ""
  type        = string
}

variable "yc_cloud_id" {
  description = "ID of a cloud"
  default     = ""
  type        = string
}

variable "yc_folder_id" {
  description = "ID of a folder"
  default     = ""
  type        = string
}

variable "yc_main_zone" {
  description = "The main availability zone"
  default     = "ru-central1-a"
  type        = string
}

variable "default_labels" {
  description = "Set of labels"
  default     = { "env" = "prod", "deployment" = "terraform" }
  type        = map(string)
}

variable "datalake_subnets" {
  type = any
  description = "CIDRs of training vpc subnets"
  default = [
                        {
                        "v4_cidr_blocks": "10.110.0.0/16",
                        "zone": "ru-central1-a"
                        },
                        {
                        "v4_cidr_blocks": "10.120.0.0/16",
                        "zone": "ru-central1-b"
                        },
                        {
                        "v4_cidr_blocks": "10.130.0.0/16",
                        "zone": "ru-central1-c"
                        }
                    ]

}

variable "dataproc_cluster_subnet" {
      description = "CIDR of dataproc cluster subnet"
      type        = string
      default     = "10.110.0.0/16"
}

variable "dataproc_cluster_name" {
      description = "name of the dataproc cluster"
      type        = string
      default     = "dataproc-main"
}


