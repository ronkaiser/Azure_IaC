# Public Load Balancer
resource "azurerm_lb" "publiclb" {
  name = "PublicLB"
  location                      = var.location
  resource_group_name = var.rg
  sku                           = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.publicip.id
  }
}

# Public Load Balancer backend pool
resource "azure_lb_backend_address_pool" "publiclbpool" {
    loadbalancer_id = azurerm_lb.publiclb.id
    name            = "FrontEndAddressPool"
}

# Public Load Balancer Pool