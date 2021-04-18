# Create public subnet
resource "azurerm_subnet" "PublicSubnet" {
  name                 = "PublicTFSubnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create private subnet
resource "azurerm_subnet" "PrivateSubnet" {
  name                 = "PrivateTFSubnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
