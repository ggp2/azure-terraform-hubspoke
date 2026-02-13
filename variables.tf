variable "location" {
  default = "francecentral"
}

variable "project" {
  default = "hubspoke"
}

variable "env" {
  description = "Environment name (dev/prod)"
}

variable "sql_admin_login" {
  default = "sqladminuser"
}

variable "sql_admin_password" {
  sensitive = true
}


