# Create public IP
resource "azurerm_public_ip" "publicip" {
  name                = "PublicIP"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
  depends_on          = [azurerm_resource_group.rg]
  sku                 = "Standard"
}