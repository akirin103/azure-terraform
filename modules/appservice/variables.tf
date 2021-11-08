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

variable "tags" {
  description = "The tags to associate with your appservice and appservice plan."
  type        = map(string)

  default = {
    environment = "dev"
  }
}

variable "virtual_network_id" {
  description = "The id of Virtual Network."
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "The id of Subnet for private endpoint."
  type        = string
}

variable "vnet_swift_connection" {
  description = "The ids of subnet for vnet integration."
  type        = string
  default     = ""
}
