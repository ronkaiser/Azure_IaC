# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "TFVnet"
    address_space       = var.cidr
    location            = var.location
    resource_group_name = var.rg
    depends_on = [azurerm_resource_group.rg]
}
