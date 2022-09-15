provider "databricks" {
  host = azurerm_databricks_workspace.main.workspace_url
}

resource "databricks_cluster" "main" {
  depends_on = [
    azurerm_databricks_workspace.main,
    module.databricks-private-endpoint-databricks_ui_api,
    module.databricks-private-endpoint-browser_authentication,
    # module.databricks-private-dns-zone-db-ui-api-c-record
  ]
  for_each = { for cluster in local.clusters : cluster.cluster_name => cluster }

  cluster_name            = each.value.cluster_name
  spark_version           = each.value.spark_version
  node_type_id            = each.value.node_type_id
  autotermination_minutes = 60
  autoscale {
    min_workers = each.value.min_workers
    max_workers = each.value.max_workers
  }
  spark_conf = each.value.spark_conf
}