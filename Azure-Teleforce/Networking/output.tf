output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vpn_gateway_ip" {
  value = azurerm_public_ip.vpn_pip.ip_address
}

output "nat_gateway_ip" {
  value = azurerm_public_ip.nat_pip.ip_address
}