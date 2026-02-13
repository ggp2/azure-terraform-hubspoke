resource "azurerm_resource_group" "rg_net" {
  name     = "rg-${var.project}-${var.env}-network"
  location = var.location
}

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-${var.project}-${var.env}-hub"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_net.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-${var.project}-${var.env}-spoke"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_net.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "peer-hub-to-spoke"
  resource_group_name       = azurerm_resource_group.rg_net.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "peer-spoke-to-hub"
  resource_group_name       = azurerm_resource_group.rg_net.name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  allow_forwarded_traffic   = true
}
