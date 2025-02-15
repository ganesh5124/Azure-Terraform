resource "azurerm_resource_group" "Testing-Resource-Group" {
    name     = var.resource_group_name
    location = var.region_name
}