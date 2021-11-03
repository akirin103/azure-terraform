variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group to be imported."
}

variable "azurerm_app_service_plan_name" {
  type        = string
  description = "The name of appservice plan."
}

variable "azurerm_app_service_name" {
  type        = string
  description = "The name of appservice."
}
