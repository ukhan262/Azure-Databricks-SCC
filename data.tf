data "azurerm_client_config" "current" {}

data "azurerm_log_analytics_workspace" "infra" {
  provider            = azurerm.private_dns_zone
  name                = "${var.company}-infra-${var.location-short-name}-log-${var.instance_number}"
  resource_group_name = "${var.company}-infra-${var.location-short-name}-rg-${var.instance_number}"
}

data "azurerm_private_dns_zone" "databricks" {
  provider            = azurerm.private_dns_zone
  name                = "privatelink.azuredatabricks.net"
  resource_group_name = "${var.company}-infra-${var.location-short-name}-rg-${var.instance_number}"
}

data "azurerm_virtual_network" "data" {
  name                = "${var.company}-${var.environment}-${var.location-short-name}-data-vnet-${var.instance_number}"
  resource_group_name = "${var.company}-${var.environment}-${var.location-short-name}-net-data-rg-${var.instance_number}"
}

data "azurerm_subnet" "dataep" {
  name                 = "${var.company}-${var.environment}-${var.location-short-name}-dataep-snet-${var.instance_number}"
  resource_group_name  = "${var.company}-${var.environment}-${var.location-short-name}-net-data-rg-${var.instance_number}"
  virtual_network_name = "${var.company}-${var.environment}-${var.location-short-name}-data-vnet-${var.instance_number}"
}

data "azurerm_subnet" "dbrkpub" {
  name                 = "${var.company}-${var.environment}-${var.location-short-name}-dbrkpub-snet-${var.instance_number}"
  resource_group_name  = "${var.company}-${var.environment}-${var.location-short-name}-net-data-rg-${var.instance_number}"
  virtual_network_name = "${var.company}-${var.environment}-${var.location-short-name}-data-vnet-${var.instance_number}"
}

data "azurerm_subnet" "dbrkpriv" {
  name                 = "${var.company}-${var.environment}-${var.location-short-name}-dbrkpriv-snet-${var.instance_number}"
  resource_group_name  = "${var.company}-${var.environment}-${var.location-short-name}-net-data-rg-${var.instance_number}"
  virtual_network_name = "${var.company}-${var.environment}-${var.location-short-name}-data-vnet-${var.instance_number}"
}

data "azurerm_subnet" "datash" {
  name                 = "${var.company}-${var.environment}-${var.location-short-name}-datash-snet-${var.instance_number}"
  resource_group_name  = "${var.company}-${var.environment}-${var.location-short-name}-net-data-rg-${var.instance_number}"
  virtual_network_name = "${var.company}-${var.environment}-${var.location-short-name}-data-vnet-${var.instance_number}"
}

data "azurerm_network_security_group" "databrkshr" {
  name                = "${var.company}-${var.environment}-${var.location-short-name}-databrkshr-nsg-${var.instance_number}"
  resource_group_name = "${var.company}-${var.environment}-${var.location-short-name}-net-data-rg-${var.instance_number}"
}

data "azurerm_network_security_group" "dataep" {
  name                = "${var.company}-${var.environment}-${var.location-short-name}-dataep-nsg-${var.instance_number}"
  resource_group_name = "${var.company}-${var.environment}-${var.location-short-name}-net-data-rg-${var.instance_number}"
}

data "azurerm_network_security_group" "datash" {
  name                = "${var.company}-${var.environment}-${var.location-short-name}-datash-nsg-${var.instance_number}"
  resource_group_name = "${var.company}-${var.environment}-${var.location-short-name}-net-data-rg-${var.instance_number}"
}