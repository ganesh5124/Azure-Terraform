
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "region_name" {
  description = "Name of the region"
  type        = string
}

variable "subnet_addresses" {
  description = "List of subnet names"
  type        = list(string)
}