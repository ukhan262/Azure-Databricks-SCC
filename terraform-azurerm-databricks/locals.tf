locals {
  name                         = var.override_name != null ? var.override_name : "${var.company}-${var.environment}-${var.location-short-name}-dbw-${var.instance_number}"
  managed_resource_group_name  = "${var.company}-${var.environment}-${var.location-short-name}-dbrkmgt-rg-${var.instance_number}"
  managed_storage_account_name = "${var.company}${var.environment}${var.location-short-name}dbkst${var.instance_number}"

  default_tags = {
    env         = var.environment
    tier        = var.tier
    infra       = var.infra
    cost_center = var.cost_center
    data        = var.data
    regulatory  = var.regulatory
    owner       = var.owner
  }
  tags              = merge(local.default_tags, var.additional_tags)
  subresource_names = ["databricks_ui_api", "browser_authentication"]

  clusters = [for cluster in var.clusters : {
    cluster_name  = join("-", [var.databricks_cluster_name, cluster.cluster_name])
    spark_version = cluster.spark_version
    node_type_id  = cluster.node_type_id
    min_workers   = cluster.min_workers
    max_workers   = cluster.max_workers
    spark_conf    = cluster.spark_conf
  }]
}