variable "kv_resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "kv_location" {
  type        = string
  description = "Location of the resource group."
}

variable "kv_name" {
  type        = string
  description = "Keyvault name"
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID"
}

variable "object_id" {
  type        = string
  description = "Object ID"
}
