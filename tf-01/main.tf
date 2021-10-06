terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.79.1"
    }
  }
}

provider "azurerm" {
  features {
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
resource "azurerm_resource_group" "demo" {
  count    = 1
  name     = "rg-cp-nebula-westeu-ccavalli-001"
  location = "westeurope"
  tags = {
    "environment" = "dev"
    "purpose"     = "cloudportal"
  }
}




