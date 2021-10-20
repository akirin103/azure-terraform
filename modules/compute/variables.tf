variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "virtual_machine_name" {
  type = string
}

variable "disk_name" {
  type = string
}

variable "vm_size" {
  default = "Standard_A1"
}

variable "network_interface" {
  type = string
}

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

# # indivisual settings


