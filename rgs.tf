# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "TFResourceGroup"
  location = var.location
}
