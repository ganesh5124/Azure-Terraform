
resource "azurerm_resource_group" "app_service_rg" {
  name = var.resource_group_name
    location = var.location
}

resource "azurerm_service_plan" "app_service_plan" {
  name = var.app_service_plan_name
  location = azurerm_resource_group.app_service_rg.location
  resource_group_name = azurerm_resource_group.app_service_rg.name
  sku_name = "S1"
  os_type = "Linux"
}

resource "azurerm_linux_web_app" "app_service_web_app1" {
  name = var.app_service_name
  location = azurerm_resource_group.app_service_rg.location
  resource_group_name = azurerm_resource_group.app_service_rg.name
  service_plan_id = azurerm_service_plan.app_service_plan.id
  site_config {}
}

resource "azurerm_linux_web_app_slot" "app_service_slot" {
  name = "${var.app_service_name}-slot"
  app_service_id = azurerm_linux_web_app.app_service_web_app1.id
  site_config {}
}