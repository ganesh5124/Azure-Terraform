output "service_principal_name" {
    value = var.service_principal_name
}

output "service_principal_object_id" {
    value = azuread_service_principal.sp.object_id
}

output "service_principal_tenant_id" {
    value = azuread_service_principal.sp.application_tenant_id
}

output "client_id" {
    value = azuread_application.sp-app.client_id
}

output "client_secret" {
    value = azuread_service_principal_password.sp-password.value
}


