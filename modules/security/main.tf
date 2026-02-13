data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg_sec" {
  name     = "rg-${var.project}-${var.env}-security"
  location = var.location
}

resource "azurerm_key_vault" "kv" {
  name                       = "kv-${var.project}-${var.env}-${var.suffix}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg_sec.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  enable_rbac_authorization  = true
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
}

# Donner à l'App Service le droit de lire les secrets (RBAC)
resource "azurerm_role_assignment" "webapp_kv_secrets_user" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.webapp_principal_id
}
