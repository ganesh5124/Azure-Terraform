
variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "mytfstatestorageaccount"
}

variable "storage_account_tier" {
  description = "The Tier to use for this Storage Account"
  type        = string
  default     = "Standard"  
}

variable "environment" {
  description = "The environment to deploy the resources"
  type        = string
  default     = "TerraformDemo"
}