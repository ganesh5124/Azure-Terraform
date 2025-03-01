variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
    default     = "provisioners-rg"
}

variable "location" {
    description = "Location of the resource group"
    type        = string
    default     = "East US"
}

#################### Networking  ########################

variable "vnet_name" {
    description = "Name of the virtual network"
    type        = string
    default     = "provisioners-vnet"
}

variable "subnet_name" {
    description = "Name of the subnet"
    type        = string
    default     = "provisioners-subnet"
}

variable "nsg_name" {
    description = "Name of the network security group"
    type        = string
    default     = "provisioners-nsg"
}

variable "public_ip_name" {
    description = "Name of the public IP"
    type        = string
    default     = "provisioners-pip"
}

variable "allocation_method" {
    description = "Allocation method of the public IP"
    type        = string
    default     = "Static"
}

variable "nic_name" {
    description = "Name of the network interface"
    type        = string
    default     = "provisioners-nic"
  
}