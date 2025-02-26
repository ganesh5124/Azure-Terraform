
resource "azurerm_resource_group" "app_service" {
  name = var.resource_group_name
    location = var.location
}

resource "azurerm_service_plan" "app_service_plan" {
  name = var.app_service_plan_name
  location = azurerm_resource_group.app_service.location
  resource_group_name = azurerm_resource_group.app_service.name
  kind = "Linux"
  reserved = true
  sku_name = "B1"
  os_type = "Linux"
}

resource "azurerm_linux_web_app" "app_service" {
  name = var.app_service_name
  location = azurerm_resource_group.app_service.location
  resource_group_name = azurerm_resource_group.app_service.name
  service_plan_id = azurerm_service_plan.app_service_plan.id
  site_config {}
}

resource "azurerm_linux_web_app_slot" "app_service_slot" {
  name = "${var.app_service_name}-slot"
  app_service_id = azurerm_service_plan.app_service_plan.id
  service_plan_id = azurerm_service_plan.app_service_plan.id
  site_config {}
}