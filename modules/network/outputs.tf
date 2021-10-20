output "example_network_interface" {
  value = [for network_interface in azurerm_network_interface.example : network_interface.id]
}
