# resource name
variable "resource_group_name" {
  default = "test-rg"
}

variable "virtual_network_name" {
  default = "test-vnet"
}

variable "subnet_name" {
  default = "test-subnet"
}

variable "virtual_machine_name" {
  default = "test-vm"
}

variable "disk_name" {
  default = "test-disk"
}

variable "network_interface_name" {
  default = "test-vnet-interface"
}

variable "public_key_name" {
  default = "test-publickey"
}

variable "network_security_group_name" {
  default = "test-nsg"
}

variable "network_security_group_rule_name" {
  default = "AllowTcpAll"
}

# indivisual settings
variable "vm_size" {
  default = "Standard_A1"
}

variable "location" {
  default = "japaneast"
}
