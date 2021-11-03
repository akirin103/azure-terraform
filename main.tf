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

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

module "appservice" {
  source                        = "./modules/appservice"
  resource_group_name           = azurerm_resource_group.this.name
  azurerm_app_service_plan_name = "test-app-plan"
  azurerm_app_service_name      = "test-app"
  depends_on                    = [azurerm_resource_group.this]
}

# module "network" {
#   source              = "Azure/network/azurerm"
#   resource_group_name = azurerm_resource_group.this.name
#   vnet_name           = var.vnet_name
#   address_spaces      = ["10.0.0.0/16"]
#   subnet_names        = ["subnet1", "subnet2", "subnet3"]
#   subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

#   subnet_enforce_private_link_endpoint_network_policies = {
#     # "subnet1" : true
#   }

#   subnet_service_endpoints = {
#     # "subnet1" : ["Microsoft.Sql"],
#     # "subnet2" : ["Microsoft.Sql"],
#     # "subnet3" : ["Microsoft.Sql"]
#   }

#   tags = {
#     environment = var.stage
#   }

#   depends_on = [azurerm_resource_group.this]
# }

# module "linuxserver" {
#   source              = "Azure/compute/azurerm"
#   resource_group_name = azurerm_resource_group.this.name
#   vm_hostname         = var.vmprefix
#   nb_public_ip        = 1
#   remote_port         = "22"
#   nb_instances        = 1
#   vm_os_publisher     = "Canonical"
#   vm_os_offer         = "UbuntuServer"
#   vm_os_sku           = "18.04-LTS"
#   vnet_subnet_id      = module.network.vnet_subnets[0]
#   # boot_diagnostics                 = true
#   delete_os_disk_on_termination = true
#   # nb_data_disk                     = 1
#   # data_disk_size_gb                = 64
#   # data_sa_type                     = "Standard_LRS"
#   enable_ssh_key = true
#   ssh_key_values = [file("~/.ssh/id_rsa.pub")]
#   vm_size        = "Standard_B1s"
#   # delete_data_disks_on_termination = true

#   tags = {
#     environment = var.stage
#   }

#   # enable_accelerated_networking = true

#   depends_on = [azurerm_resource_group.this, module.network]
# }
