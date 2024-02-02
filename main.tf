# 1. Specify the version of the AzureRM Provider to use
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }
}

terraform {
backend "azurerm" {
        resource_group_name  = "GPA-Prod"
        storage_account_name = "tfstatestorageaccount34"
        container_name       = "tfstatecontainer"
        key                  = "terraform.tfstate"
        access_key           =  "xxxxx"
    }
}

provider "azurerm" {
  features {}
  client_id       = "xxx"
  client_secret   = "xxx"
  tenant_id       = "xxx"
  subscription_id = "xxx"
}


resource "azurerm_resource_group" "rg" {
  name     = "GPA-Prod"
  location = "UK South"

  tags = {
    Ram = "Ram"
  }

  }
resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstatestorageaccount34"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "tfstatecontainer" {
  name                  = "tfstatecontainer"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
}


