resource "azurerm_lb" "lbnew" {
  name                = "TestLoadBalancer"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress1"
    public_ip_address_id = azurerm_public_ip.mypublicip.id
  }
}

resource "azurerm_lb_backend_address_pool" "bep" {
  loadbalancer_id = azurerm_lb.lbnew.id
  name            = "BackEndAddressPool"
}

# Resource-4: Create LB Probe
resource "azurerm_lb_probe" "app_lb_probe" {
  name                = "tcp-probe"
  protocol            = "Tcp"
  port                = 80
  loadbalancer_id     = azurerm_lb.lbnew.id
  resource_group_name = azurerm_resource_group.myrg.name
}

# Resource-5: Create LB Rule
resource "azurerm_lb_rule" "app_lb_rule_app1" {
  name                           = "app-app1-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lbnew.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bep.id] 
  probe_id                       = azurerm_lb_probe.app_lb_probe.id
  loadbalancer_id                = azurerm_lb.lbnew.id
  resource_group_name            = azurerm_resource_group.myrg.name

}
