output "rg_network_name" {
  value = azurerm_resource_group.rg_net.name
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.hub.id
}

output "spoke_vnet_id" {
  value = azurerm_virtual_network.spoke.id
}
