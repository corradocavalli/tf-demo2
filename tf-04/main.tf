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


module "acr" {
  source              = "./modules/keyvault"
  prefix              = local.prefix
  resource_group_name = local.resource_group_name
  location            = var.resource_group_location
}

//module output values can be used by referencing module.acr.keyvault_id

output "keyvault_id" {
  value = module.acr.keyvault_id
}

output "keyvault_uri" {
  value = module.acr.keyvault_uri
}




