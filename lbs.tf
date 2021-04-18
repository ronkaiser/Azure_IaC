# Public Load Balancer
resource "azurerm_lb" "publiclb" {
  name = "PublicLB"
  location            = var.location
  resource_group_name = var.rg
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.publicip.id
  }
}

# Public Load Balancer backend pool
resource "azurerm_lb_backend_address_pool" "publiclbpool" {
  loadbalancer_id     = azurerm_lb.publiclb.id
  name                = "BackEndAddressPool"
  resource_group_name = var.rg
}

# Public Load Balancer Pool associations
resource "azurerm_network_interface_backend_address_pool_association" "webpool" {
  for_each                = toset(var.app_vm)
  network_interface_id    = azurerm_network_interface.PublicNIC[each.key].id
  backend_address_pool_id = azurerm_lb_backend_address_pool.publiclbpool.id
  ip_configuration_name = each.value
}
