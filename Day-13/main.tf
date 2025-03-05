# Example for Dynamic Expression by taking vnet, subnet and security group as input
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.region_name
}



# Splat Expression Example
output "security_rule" {
  value = azurerm_network_security_group.nsg.security_rule[*].name
}