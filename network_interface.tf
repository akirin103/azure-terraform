resource "azurerm_network_interface" "mynetworkinterface" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypublickey.id
  }
}

resource "azurerm_public_ip" "mypublickey" {
  name                = var.public_key_name
  resource_group_name = azurerm_resource_group.myterraformgroup.name
  location            = var.location
  allocation_method   = "Dynamic"
}
