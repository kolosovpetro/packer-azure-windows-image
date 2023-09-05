output "subnet_id" {
  value = azurerm_subnet.internal.id
}

output "vnet_id" {
  value = azurerm_virtual_network.public.id
}
