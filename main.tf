terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.73.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source                      = "./modules/network"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.example.name
  virtual_network_name        = var.virtual_network_name
  virtual_network_address     = [var.virtual_network_address]
  subnet                      = var.subnet
  network_security_group_name = var.azurerm_network_security_group
}

# module "network2" {
#   source                  = "./modules/network"
#   location                = var.location
#   resource_group_name     = azurerm_resource_group.example.name
#   virtual_network_name    = "test-net2"
#   virtual_network_address = [var.virtual_network_address2]
#   subnet                  = var.subnet2
#   network_security_group_name = var.azurerm_network_security_group2
# }

module "compute" {
  source               = "./modules/compute"
  location             = var.location
  resource_group_name  = azurerm_resource_group.example.name
  virtual_machine_name = var.virtual_machine_name
  network_interface    = module.network.example_network_interface[0]
  disk_name            = var.disk_name
}
