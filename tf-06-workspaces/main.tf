
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

resource "random_integer" "sa_num" {
  min = 10000
  max = 99999
}

locals {
  rg_name = "${var.resource_group_name}-${var.loc_prefix[terraform.workspace]}-${var.devname}-${terraform.workspace}"
  ct_name = "tf-${terraform.workspace}"
}


resource "azurerm_resource_group" "setup" {
  name     = local.rg_name
  location = var.locations[terraform.workspace]
}

resource "azurerm_storage_account" "sa" {
  name                     = "${lower(var.prefix)}${random_integer.sa_num.result}"
  resource_group_name      = azurerm_resource_group.setup.name
  location                 = var.locations[terraform.workspace]
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "ct" {
  name                 = local.ct_name
  storage_account_name = azurerm_storage_account.sa.name
}

#Output variables
output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "resource_group_name" {
  value = azurerm_resource_group.setup.name
}
