variable "vnet_name" {
  type        = string
  default     = ""
  description = "description"
}

variable "vnet_address_space" {
    type        = list(string)
    default     = ["10.0.0.0/16"]
    description = "The address space that is used by the virtual network."
}

variable "prod_public_subnet_address" {
  type        = list(string)
  default     = []
  description = "description"
}

variable "prod_private_subnet_address" {
  type        = list(string)
  default     = []
  description = "description"
}

variable "prod_public_subnets" {
  type        = list(string)
  default     = []
  description = "description"
}

variable "prod_private_subnets" {
  type        = list(string)
  default     = []
  description = "description"
}

variable "nsg_name" {
  type        = string
  default     = ""
  description = "description"
}