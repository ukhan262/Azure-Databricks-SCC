variable "company" {
  type    = string
  default = "umar"
}

variable "override_name" {
  type    = string
  default = null
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "North Central US"
}

variable "location-short-name" {
  type    = string
  default = "ncus"
}

variable "instance_number" {
  type    = string
  default = "001"
}

variable "sku" {
  type    = string
  default = "standard"
}

variable "network_security_group_rules_required" {
  type    = string
  default = "AllRules"
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "public_subnet_name" {
  type = string
}

variable "private_subnet_name" {
  type = string
}

variable "private_subnet_network_security_group_association_id" {
  type = string
}

variable "public_subnet_network_security_group_association_id" {
  type = string
}

variable "vnet_address_prefix" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "additional_tags" {
  type    = map(any)
  default = {}
}

variable "environment" {
  type    = string
  default = "eval"
}

variable "tier" {
  type    = string
  default = "data"
}

variable "infra" {
  type    = string
  default = "yes"
}

variable "cost_center" {
  type    = string
  default = "9575"
}

variable "data" {
  type    = string
  default = ""
}

variable "regulatory" {
  type    = string
  default = ""
}

variable "owner" {
  type    = string
  default = ""
}

variable "storage_account_sku_name" {
  type    = string
  default = null
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "key_vault_id" {
  type    = string
  default = "value"
}

variable "private_dns_zone_name" {
  type    = string
  default = null
}

variable "private_dns_zone_ids" {
  type    = list(string)
  default = []
}

variable "custom_private_dns_zone_ids" {
  type    = list(string)
  default = []
}

variable "enable_custom_client_dns_deployment" {
  type    = bool
  default = true
}

variable "databricks_cluster_name" {
  type    = string
  default = "dbrks"
}

variable "clusters" {
  type = list(object({
    cluster_name  = string
    spark_version = string
    node_type_id  = string
    min_workers   = number
    max_workers   = number
    spark_conf    = map(any)
  }))
  default = [
    {
      cluster_name = "cluster001"
      max_workers  = 3
      min_workers  = 1
      node_type_id = "Standard_DS3_v2"
      spark_conf = {
        "spark.databricks.cluster.profile" : "serverless"
        "spark.databricks.repl.allowedLanguages" : "python, scala, sql"
        "spark.databricks.passthrough.enabled" : true
        "spark.databricks.pyspark.enableProcessIsolation" : true
      }
      spark_version = "10.5.x-scala2.12"
    }
  ]
}
