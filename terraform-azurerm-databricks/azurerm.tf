data "azurerm_client_config" "current" {}

resource "azurerm_databricks_workspace" "main" {
  name                                  = local.name
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  sku                                   = var.sku
  network_security_group_rules_required = var.network_security_group_rules_required
  managed_resource_group_name           = local.managed_resource_group_name

  public_network_access_enabled = var.public_network_access_enabled

  custom_parameters {
    public_subnet_name                                   = var.public_subnet_name
    private_subnet_name                                  = var.private_subnet_name
    private_subnet_network_security_group_association_id = var.private_subnet_network_security_group_association_id
    public_subnet_network_security_group_association_id  = var.public_subnet_network_security_group_association_id
    storage_account_name                                 = local.managed_storage_account_name
    storage_account_sku_name                             = var.storage_account_sku_name == null ? "Standard_LRS" : var.storage_account_sku_name
    virtual_network_id                                   = var.virtual_network_id
    vnet_address_prefix                                  = var.vnet_address_prefix

    # security standard
    no_public_ip = true
  }
  tags = local.tags
}

module "databricks-private-endpoint-databricks_ui_api" {
  count                          = var.sku == "premium" ? 1 : 0
  source                         = "../terraform-azurerm-private_endpoint"
  prefix                         = "${azurerm_databricks_workspace.main.name}-databricks_ui_api"
  resource_group_name            = azurerm_databricks_workspace.main.resource_group_name
  location                       = azurerm_databricks_workspace.main.location
  subnet_id                      = var.subnet_id
  subresource_names              = ["databricks_ui_api"]
  private_connection_resource_id = azurerm_databricks_workspace.main.id
  environment                    = var.environment
  tier                           = var.tier
  infra                          = var.infra
  cost_center                    = var.cost_center
  data                           = var.data
  regulatory                     = var.regulatory
  owner                          = var.owner
  private_dns_zone_group = [{
    name                 = "privatelink.azuredatabricks.net"
    private_dns_zone_ids = var.private_dns_zone_ids
  }]

}

module "databricks-private-endpoint-browser_authentication" {
  count = var.sku == "premium" ? 1 : 0
  depends_on = [
    module.databricks-private-endpoint-databricks_ui_api[0]
  ]
  source                         = "../terraform-azurerm-private_endpoint"
  prefix                         = "${azurerm_databricks_workspace.main.name}-browser_authentication"
  resource_group_name            = azurerm_databricks_workspace.main.resource_group_name
  location                       = azurerm_databricks_workspace.main.location
  subnet_id                      = var.subnet_id
  subresource_names              = ["browser_authentication"]
  private_connection_resource_id = azurerm_databricks_workspace.main.id
  environment                    = var.environment
  tier                           = var.tier
  infra                          = var.infra
  cost_center                    = var.cost_center
  data                           = var.data
  regulatory                     = var.regulatory
  owner                          = var.owner
  private_dns_zone_group = [{
    name                 = "privatelink.azuredatabricks.net"
    private_dns_zone_ids = var.private_dns_zone_ids
  }]

}