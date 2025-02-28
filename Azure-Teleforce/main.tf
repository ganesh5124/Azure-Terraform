
resource "azurerm_resource_group" "teleforce-prod" {
  name     = var.resource_group_name
  location = var.location
}