data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "public" {
  location = var.resource_group_location
  name     = "rg-packer-${var.prefix}"
}

module "network" {
  source                  = "./modules/network"
  resource_group_location = azurerm_resource_group.public.location
  resource_group_name     = azurerm_resource_group.public.name
  subnet_name             = "vm-win-subnet-${var.prefix}"
  vnet_name               = "vm-win-vnet-${var.prefix}"

  depends_on = [
    azurerm_resource_group.public
  ]
}

module "storage" {
  source                      = "./modules/storage"
  storage_account_name        = "storvmwin${var.prefix}"
  storage_account_replication = var.storage_account_replication
  storage_account_tier        = var.storage_account_tier
  storage_container_name      = "contvmwin${var.prefix}"
  storage_location            = azurerm_resource_group.public.location
  storage_resource_group_name = azurerm_resource_group.public.name

  depends_on = [
    azurerm_resource_group.public
  ]
}

module "key_vault" {
  source                 = "./modules/keyvault"
  kv_location            = azurerm_resource_group.public.location
  kv_name                = "kv-vm-win-${var.prefix}"
  kv_resource_group_name = azurerm_resource_group.public.name
  object_id              = data.azurerm_client_config.current.object_id
  tenant_id              = data.azurerm_client_config.current.tenant_id
}

module "key_vault_secrets" {
  source                    = "./modules/keyvault-secrets"
  keyvault_id               = module.key_vault.id
  storage_access_url        = module.storage.storage_access_url
  storage_account_name      = module.storage.storage_account_name
  storage_connection_string = module.storage.storage_connection_string
  storage_container_name    = module.storage.storage_container_name
  storage_primary_key       = module.storage.storage_primary_key

  depends_on = [
    module.key_vault,
    module.storage
  ]
}

module "virtual_machine" {
  source                            = "./modules/vm"
  ip_configuration_name             = "vm-win-ip-config-${var.prefix}"
  network_interface_name            = "vm-win-nic-${var.prefix}"
  os_profile_admin_password         = var.os_profile_admin_password
  os_profile_admin_username         = var.os_profile_admin_username
  os_profile_computer_name          = "vm-win-${var.prefix}"
  public_ip_name                    = "vm-win-ip-${var.prefix}"
  resource_group_location           = azurerm_resource_group.public.location
  resource_group_name               = azurerm_resource_group.public.name
  storage_image_reference_offer     = var.storage_image_reference_offer
  image_resource_group_name         = var.image_resource_group_name
  storage_image_reference_publisher = var.storage_image_reference_publisher
  storage_image_reference_sku       = var.storage_image_reference_sku
  storage_image_reference_version   = var.storage_image_reference_version
  storage_os_disk_caching           = var.storage_os_disk_caching
  storage_os_disk_create_option     = var.storage_os_disk_create_option
  storage_os_disk_managed_disk_type = var.storage_os_disk_managed_disk_type
  storage_os_disk_name              = "vm-win-os-disk-${var.prefix}"
  subnet_id                         = module.network.subnet_id
  vm_name                           = "vm-win-${var.prefix}"
  vm_size                           = var.vm_size
  nsg_name                          = "vm-win-nsg-${var.prefix}"

  depends_on = [
    module.network,
    azurerm_resource_group.public
  ]
}

module "keyvault_access_policy" {
  source      = "./modules/keyvault-access-policy"
  keyvault_id = module.key_vault.id
  object_id   = module.virtual_machine.principal_id
  tenant_id   = data.azurerm_client_config.current.tenant_id

  depends_on = [
    module.key_vault,
    module.virtual_machine
  ]
}

module "custom_script_extension" {
  count                                 = var.custom_script_extension_enabled ? 1 : 0
  source                                = "./modules/custom-script-extension"
  custom_script_extension_absolute_path = "E:/RiderProjects/03_TERRAFORM_PROJECTS/packer-azure-windows-image/scripts/install_iis.ps1"
  custom_script_extension_file_name     = "install_iis.ps1"
  extension_name                        = "extension1"
  storage_account_name                  = module.storage.storage_account_name
  storage_container_name                = module.storage.storage_container_name
  virtual_machine_id                    = module.virtual_machine.id

  depends_on = [
    module.storage,
    module.virtual_machine
  ]
}
