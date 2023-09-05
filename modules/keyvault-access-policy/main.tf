resource "azurerm_key_vault_access_policy" "kv_read_access_policy" {
  key_vault_id = var.keyvault_id

  tenant_id = var.tenant_id
  object_id = var.object_id

  secret_permissions = [
    "Get",
    "List"
  ]

  certificate_permissions = [
    "Get",
    "List"
  ]

  key_permissions = [
    "Get",
    "List"
  ]
}
