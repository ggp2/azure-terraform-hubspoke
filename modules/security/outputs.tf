output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}

output "rg_name" {
  value = azurerm_resource_group.rg_sec.name
}
