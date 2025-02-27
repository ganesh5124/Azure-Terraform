
variable "resource_group_name" {
  description = "Name of the resource group" 
  default = "app-service-rg"
}

variable "location" {
  description = "Location of the resource group"
  default = "East US"
}

variable "app_service_plan_name" {
  description = "Name of the app service plan"
  default = "app-service-plan"
}

variable "app_service_name" {
  description = "Name of the app service"
  default = "appservicewebappfordemo"
}