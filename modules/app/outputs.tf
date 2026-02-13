output "rg_name" {
  value = azurerm_resource_group.rg_app.name
}

output "webapp_default_hostname" {
  value = azurerm_linux_web_app.web.default_hostname
}

output "webapp_principal_id" {
  value = azurerm_linux_web_app.web.identity[0].principal_id
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.sql.fully_qualified_domain_name
}
