provider "azurerm" {
  features {}
}

module "network" {
  source   = "./modules/network"
  location = var.location
  project  = var.project
  env      = var.env
}



resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}


module "monitoring" {
  source   = "./modules/monitoring"
  location = var.location
  project  = var.project
  env      = var.env
}

module "app" {
  source   = "./modules/app"
  location = var.location
  project  = var.project
  env      = var.env
  suffix   = random_string.suffix.result

  log_analytics_workspace_id = module.monitoring.workspace_id

  sql_admin_login    = var.sql_admin_login
  sql_admin_password = var.sql_admin_password

  # on passe KV plus tard (après sa création) -> on crée d'abord KV sans RBAC app ? non:
  # On va créer d'abord l'app, puis KV avec RBAC app, puis secret.
  # Pour éviter le cycle, on crée KV après avoir l'identity.
  key_vault_id = module.security.key_vault_id
}

module "security" {
  source   = "./modules/security"
  location = var.location
  project  = var.project
  env      = var.env
  suffix   = random_string.suffix.result

  webapp_principal_id = module.app.webapp_principal_id
}
