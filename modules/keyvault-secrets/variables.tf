variable "keyvault_id" {
  type        = string
  description = "The ID of the Key Vault to use for secrets"
}

variable "storage_connection_string" {
  type        = string
  description = "The connection string for the storage account"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account"
}

variable "storage_primary_key" {
  type        = string
  description = "The primary key for the storage account"
}

variable "storage_container_name" {
  type        = string
  description = "The name of the storage container"
}

variable "storage_access_url" {
  type        = string
  description = "The URL for the storage account"
}
