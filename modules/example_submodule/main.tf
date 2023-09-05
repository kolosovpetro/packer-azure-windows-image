locals {
  rg_name = var.resource_group_name
}

resource "azurerm_resource_group" "public" {
  location = var.resource_group_location
  name     = local.rg_name
}
