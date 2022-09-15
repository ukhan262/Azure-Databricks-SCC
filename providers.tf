terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 3.12.0"
      configuration_aliases = [azurerm.private_dns_zone]
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "private_dns_zone"
  subscription_id = ""
  features {}
}
