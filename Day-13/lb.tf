resource "azurerm_lb" "lb" {
    name                = "day13-lb"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    sku                 = "Basic"
    frontend_ip_configuration {
      name = "PublicIPAddress"
        public_ip_address_id = azurerm_public_ip.pip.id
    }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
    name                = "backendPool"
    loadbalancer_id     = azurerm_lb.lb.id
}

