# resource name
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "virtual_network_address" {
  type = list(string)
}

variable "subnet_name" {
  default = "test-subnet"
}

variable "network_interface_name" {
  default = "test-vnet-interface"
}

variable "public_ip_name" {
  default = "test-ip"
}

variable "network_security_group_name" {
  type = string
}

variable "network_security_group_rule_name" {
  default = "AllowTcpAll"
}

variable "subnet" {
  type = any
}
