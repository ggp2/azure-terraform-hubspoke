terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tf-backend"
    storage_account_name = "tfstate48753"
    container_name       = "tfstate"
    key                  = "hubspoke.tfstate"
  }
}
