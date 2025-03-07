data "azuread_client_config" "current" {}

resource "azuread_application" "sp-app" {
    display_name = var.service_principal_name
    owners = [data.azuread_client_config.current.object_id] 
}
resource "azuread_service_principal" "sp" {
  app_role_assignment_required = true
  client_id = azuread_application.sp-app.client_id
  owners = [ data.azuread_client_config.current.object_id ]
}

resource "azuread_service_principal_password" "sp-password" {
  service_principal_id = azuread_service_principal.sp.id
}