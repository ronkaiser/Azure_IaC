# Create Network Security Group for public and rule
resource "azurerm_network_security_group" "PublicNSG" {
  name                = "PublicTFNSG"
  location            = var.location
  resource_group_name = var.rg
  depends_on = [azurerm_resource_group.rg]

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "public_8080"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "8080"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }
}

# Public NSG associatioin
resource "azurerm_subnet_network_security_group_association" "PublicNSGAssociation" {
   subnet_id      = azurerm_subnet.PublicSubnet.id
   network_security_group_id = azurerm_network_security_group.PublicNSG.id
}

# Create Network Security Group for private and rule
resource "azurerm_network_security_group" "PrivateNSG" {
  name                = "PrivateTFNSG"
  location            = var.location
  resource_group_name = var.rg
  depends_on = [azurerm_resource_group.rg]

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "private_5432"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "5432"
    destination_port_range     = "5432"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
}

# Private NSG associatioin
resource "azurerm_subnet_network_security_group_association" "PrivateNSGAssociation" {
   subnet_id      = azurerm_subnet.PrivateSubnet.id
   network_security_group_id = azurerm_network_security_group.PrivateNSG.id
}
