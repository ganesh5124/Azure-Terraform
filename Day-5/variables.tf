variable "region_name" {}
variable "resource_group_name" {}
variable "subscription_id" {}
variable "storage_account_name" {}
variable "storage_account_tier" {}
variable "storage_account_replication_type" {}
# Example of object type variable
variable "tags" {
  type = map(string)
    default = {
        environment = "dev"
        project     = "learn-terraform"
    }
}
