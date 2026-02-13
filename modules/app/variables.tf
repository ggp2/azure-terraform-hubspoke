variable "location" {}
variable "project" {}
variable "env" {}
variable "suffix" {}

variable "log_analytics_workspace_id" {}

variable "sql_admin_login" {}
variable "sql_admin_password" {
  sensitive = true
}

variable "key_vault_id" {}
