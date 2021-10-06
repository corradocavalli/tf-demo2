terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.79.1"
    }
  }
}

locals {
  resource_group_name = "rg-cp-nebula-westeu-${var.developer_name}-001"
}


provider "azurerm" {
  features {
  }
}


resource "azurerm_resource_group" "demo" {
  count    = var.create_resource_group ? 1 : 0
  name     = local.resource_group_name
  location = var.resource_group_location
  tags = {
    "dev"    = var.developer_name
    "reason" = "cloudportal"
  }
}




