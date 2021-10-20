resource "azurerm_linux_virtual_machine" "myterraformvm" {
  name                  = var.virtual_machine_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_ds1_v2"
  admin_username        = "adminuser"
  network_interface_ids = [var.network_interface]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19.04"
    version   = "latest"
  }
}
