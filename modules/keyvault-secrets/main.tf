resource "azurerm_key_vault_secret" "storage_connection_string" {
  name         = "StorageConnectionString"
  value        = var.storage_connection_string
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "storage_account_name" {
  name         = "StorageAccountName"
  value        = var.storage_account_name
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "storage_primary_key" {
  name         = "StoragePrimaryKey"
  value        = var.storage_primary_key
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "storage_container_name" {
  name         = "StorageContainerName"
  value        = var.storage_container_name
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "storage_access_url" {
  name         = "StorageAccessUrl"
  value        = var.storage_access_url
  key_vault_id = var.keyvault_id
}
