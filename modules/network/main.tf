resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "example" {
  for_each = { for i in var.subnet : i.name => i }

  name                 = each.value.name
  address_prefixes     = [each.value.cidr]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
}

resource "azurerm_network_security_group" "example" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = var.network_security_group_rule_name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  for_each                  = { for i in var.subnet : i.name => i if i.tcpAllow == true }
  subnet_id                 = azurerm_subnet.example[each.key].id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_network_interface" "example" {
  for_each            = { for i in var.subnet : i.name => i if i.network_interface != "" }
  name                = each.value.network_interface
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example[each.key].id
  }
}

resource "azurerm_public_ip" "example" {
  for_each            = { for i in var.subnet : i.name => i if i.public_ip != "" }
  name                = each.value.public_ip
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}
