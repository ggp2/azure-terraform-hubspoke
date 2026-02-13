output "network_rg" {
  value = module.network.rg_network_name
}

output "hub_vnet_id" {
  value = module.network.hub_vnet_id
}

output "spoke_vnet_id" {
  value = module.network.spoke_vnet_id
}

output "log_analytics_workspace_id" {
  value = module.monitoring.workspace_id
}

output "key_vault_uri" {
  value = module.security.key_vault_uri
}

output "webapp_default_hostname" {
  value = module.app.webapp_default_hostname
}

output "sql_server_fqdn" {
  value = module.app.sql_server_fqdn
}
