resource "azurerm_storage_blob" "public" {
  name                   = var.custom_script_extension_file_name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = "Block"
  source                 = var.custom_script_extension_absolute_path
}

resource "azurerm_virtual_machine_extension" "public" {
  name                 = var.extension_name
  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  depends_on = [
    azurerm_storage_blob.public
  ]

  settings = <<SETTINGS
        {
            "fileUris": [
                "${azurerm_storage_blob.public.url}"
                ],
            "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File ${var.custom_script_extension_file_name}"
        }
    SETTINGS
}
