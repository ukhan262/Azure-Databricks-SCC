terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 3.12.0"
      configuration_aliases = [azurerm.private_dns_zone]
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.2"
    }
  }
}
