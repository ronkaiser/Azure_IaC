# Public Load Balancer
resource "azurerm_lb" "publiclb" {
  name                = "PublicLB"
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
  for_each =  toset(var.app_vm)
  depends_on = [azurerm_network_interface.PublicNIC]
  network_interface_id    = azurerm_network_interface.PublicNIC[each.key].id
  backend_address_pool_id = azurerm_lb_backend_address_pool.publiclbpool.id
  ip_configuration_name   = "ipconfig"
}

# Public Load Balancer SSH probe
resource "azurerm_lb_probe" "publicsshprobe" {
  loadbalancer_id     = azurerm_lb.publiclb.id
  name                = "22-Probe"
  port                = 22
  resource_group_name = var.rg
}

# Public Load Balancer HTTP probe
resource "azurerm_lb_probe" "publichttpprobe" {
  loadbalancer_id     = azurerm_lb.publiclb.id
  name                = "8080-Probe"
  port                = 8080
  resource_group_name = var.rg
}

resource "azurerm_lb_rule" "publicsshrule" {
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.publiclb.frontend_ip_configuration[0].name
  frontend_port                  = 22
  loadbalancer_id                = azurerm_lb.publiclb.id
  name                           = "PublicSSHRule"
  protocol                       = "Tcp"
  resource_group_name            = var.rg
  probe_id                       = azurerm_lb_probe.publicsshprobe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.publiclbpool.id

}

resource "azurerm_lb_rule" "publichttprule" {
  backend_port                   = 8080
  frontend_ip_configuration_name = azurerm_lb.publiclb.frontend_ip_configuration[0].name
  frontend_port                  = 8080
  loadbalancer_id                = azurerm_lb.publiclb.id
  name                           = "PublicHTTPRule"
  protocol                       = "Tcp"
  resource_group_name            = var.rg
  probe_id                       = azurerm_lb_probe.publichttpprobe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.publiclbpool.id
}