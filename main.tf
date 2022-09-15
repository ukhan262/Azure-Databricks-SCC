#########################################
########## AZURE DATA BRICKS ############
#########################################

module "databricks" {
  providers = {
    azurerm.private_dns_zone = azurerm.private_dns_zone
  }
  source                                               = "./modules/terraform-azurerm-databricks"
  location                                             = var.location
  location-short-name                                  = var.location-short-name
  instance_number                                      = var.instance_number
  environment                                          = var.environment
  tier                                                 = var.tier
  data                                                 = var.data
  regulatory                                           = var.regulatory
  infra                                                = var.infra
  cost_center                                          = var.cost_center
  owner                                                = var.owner
  resource_group_name                                  = module.resource_group.name
  network_security_group_rules_required                = "NoAzureDatabricksRules"
  public_network_access_enabled                        = false
  public_subnet_name                                   = "${var.company}-${var.environment}-${var.location-short-name}-dbrkpub-snet-${var.instance_number}"
  private_subnet_name                                  = "${var.company}-${var.environment}-${var.location-short-name}-dbrkpriv-snet-${var.instance_number}"
  private_subnet_network_security_group_association_id = data.azurerm_network_security_group.databrkshr.id
  public_subnet_network_security_group_association_id  = data.azurerm_network_security_group.databrkshr.id
  virtual_network_id                                   = data.azurerm_virtual_network.data.id
  vnet_address_prefix                                  = join("", data.azurerm_virtual_network.data.address_space)
  subnet_id                                            = data.azurerm_subnet.dataep.id
  key_vault_id                                         = module.key_vault.main.id
  private_dns_zone_ids                                 = [data.azurerm_private_dns_zone.databricks.id]
  sku                                                  = "premium"
  clusters = [
    {
      cluster_name = "cluster001"
      max_workers  = 3
      min_workers  = 1
      node_type_id = "Standard_DS3_v2"
      spark_conf = {
      }
      spark_version = "10.4.x-scala2.12"
    }
  ]
}