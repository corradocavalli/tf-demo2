terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.79.1"
    }
  }
}

#Generates a random id
resource "random_id" "prefix" {
  byte_length = 3
  prefix      = "abb" # we add a prefix to prevent errors with those resources whose name can't begin with a number
}

locals {
  resource_group_name = "rg-cp-nebula-westeu-${var.developer_name}-001"
  prefix              = random_id.prefix.hex
}


provider "azurerm" {
  features {
  }
}


#Resource group
resource "azurerm_resource_group" "demo" {
  name     = local.resource_group_name
  location = var.resource_group_location
  tags = {
    "dev"    = var.developer_name
    "reason" = "cloudportal"
  }
}


#Gets the configuration of the AzureRM provider
data "azurerm_client_config" "current" {}


#Azure Keyvault
resource "azurerm_key_vault" "demo" {
  name                        = "${local.prefix}-keyvault"
  location                    = var.resource_group_location
  resource_group_name         = local.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
}

#Grant key vault access to current terraform user
resource "azurerm_key_vault_access_policy" "demo" {
  key_vault_id = azurerm_key_vault.demo.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "get", "set", "list", "delete", "purge"
  ]
}




