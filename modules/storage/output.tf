output "storage_connection_string" {
  value     = azurerm_storage_account.public.primary_connection_string
  sensitive = true
}

output "storage_account_name" {
  value = azurerm_storage_account.public.name
}

output "storage_container_name" {
  value = azurerm_storage_container.public.name
}

output "storage_access_url" {
  value = "https://${azurerm_storage_account.public.name}.blob.core.windows.net/${azurerm_storage_container.public.name}/"
}

output "storage_primary_key" {
  value     = azurerm_storage_account.public.primary_access_key
  sensitive = true
}
