resource "azurerm_resource_group" "rg_mon" {
  name     = "rg-${var.project}-${var.env}-monitoring"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-${var.project}-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_mon.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
