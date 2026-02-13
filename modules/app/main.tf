resource "azurerm_resource_group" "rg_app" {
  name     = "rg-${var.project}-${var.env}-app"
  location = var.location
}

# App Service Plan (Linux)
resource "azurerm_service_plan" "plan" {
  name                = "asp-${var.project}-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_app.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Web App (Linux) + Managed Identity
resource "azurerm_linux_web_app" "web" {
  name                = "app-${var.project}-${var.env}-${var.suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_app.name
  service_plan_id     = azurerm_service_plan.plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = true
    application_stack {
      python_version = "3.11"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

# SQL Server + DB
resource "azurerm_mssql_server" "sql" {
  name                         = "sql-${var.project}-${var.env}-${var.suffix}"
  resource_group_name          = azurerm_resource_group.rg_app.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "db" {
  name      = "db-${var.project}-${var.env}"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = "Basic"
}

# Autoriser les services Azure à accéder au SQL (simple pour lab)
resource "azurerm_mssql_firewall_rule" "allow_azure" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Stocker la connexion DB dans Key Vault (secret)
resource "azurerm_key_vault_secret" "db_conn" {
  name         = "DbConnectionString"
  key_vault_id = var.key_vault_id
  value        = "Server=tcp:${azurerm_mssql_server.sql.fully_qualified_domain_name},1433;Database=${azurerm_mssql_database.db.name};User ID=${var.sql_admin_login};Password=${var.sql_admin_password};Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}


resource "azurerm_monitor_diagnostic_setting" "web_diag" {
  name                       = "diag-web"
  target_resource_id         = azurerm_linux_web_app.web.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AppServiceHTTPLogs"
  }
  enabled_log {
    category = "AppServiceConsoleLogs"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

