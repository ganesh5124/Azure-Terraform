############################# Default Resources ########################################################
variable "resource_group_name" {
  default = "teleforce-prod-rg"
}

variable "location" {
  default = "eastus"
}

############################# Networking ########################################################
variable "vnet_name" {
  default = "teleforce-prod-vnet"
}

variable "public_subnet_address_prefixes" {
  type = list(string)
  default = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

variable "private_subnet_address_prefixes" {
  type = list(string)
  default = ["10.0.40.0/24", "10.0.50.0/24", "10.0.60.0/24"]
}

############################# AKS ########################################################

variable "cluster_name" {
  default = "teleforce-prod"
}

variable "dns_prefix" {
  default = "teleprod"
}

variable "node_count" {
  default = 3
}

variable "node_vm_size" {
  default = "Standard_D2s_v3"
}

variable "min_node_count" {
  default = 3
}

variable "max_node_count" {
  default = 5
}

variable "acr_name" {
  default = "aksprodacr"
}