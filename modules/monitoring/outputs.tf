output "workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "rg_name" {
  value = azurerm_resource_group.rg_mon.name
}
