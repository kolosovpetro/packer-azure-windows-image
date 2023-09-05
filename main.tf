data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "public" {
  location = var.resource_group_location
  name     = local.rg_name
}

module "resource_group" {
  source                  = "./modules/example_submodule"
  resource_group_location = "northeurope"
  resource_group_name     = "rg-from-module"
}
