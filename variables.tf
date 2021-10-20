# Common
variable "resource_group_name" {
  default = "test-rg"
}

variable "location" {
  default = "japaneast"
}

# network
variable "virtual_network_name" {
  default = "test-vnet"
}

variable "virtual_network_address" {
  default = "10.0.0.0/16"
}

variable "subnet" {
  default = [
    {
      cidr              = "10.0.1.0/24",
      name              = "test1",
      tcpAllow          = true,
      network_interface = "network_interface1",
      public_ip         = "public_ip1",
    },
    {
      cidr              = "10.0.2.0/24",
      name              = "test2",
      tcpAllow          = false,
      network_interface = "",
      public_ip         = "",
    },
  ]
}

variable "azurerm_network_security_group" {
  default = "security_group"
}

variable "virtual_machine_name" {
  default = "test-vm"
}

variable "disk_name" {
  default = "test-disk"
}


# variable "virtual_network_address2" {
#   default = "172.31.0.0/16"
# }

# variable "subnet2" {
#   default = [
#     {
#       cidr = "172.31.0.0/24",
#       name = "test3",
#       tcpAllow = true,
#       network_interface = "network_interface3",
#       public_ip = "public_ip3",
#     },
#     {
#       cidr = "172.31.1.0/24",
#       name = "test4",
#       tcpAllow = false,
#       network_interface = "",
#       public_ip = "",
#     },
#   ]
# }

# variable "azurerm_network_security_group2" {
#   default = "security_group2"
# }

# variable "disk_name" {
#   default = "test-disk"
# }

# variable "network_interface_name" {
#   default = "test-vnet-interface"
# }

# variable "public_key_name" {
#   default = "test-publickey"
# }

# variable "network_security_group_name" {
#   default = "test-nsg"
# }

# variable "network_security_group_rule_name" {
#   default = "AllowTcpAll"
# }

# indivisual settings
# variable "vm_size" {
#   default = "Standard_A1"
# }

# variable "virtual_network_address" {
#   default = "10.0.0.0/16"
# }

# variable "virtual_machine_name" {
#   default = "test-vm"
# }
