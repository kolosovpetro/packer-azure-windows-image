variable "keyvault_id" {
  type        = string
  description = "The ID of the Key Vault to which the role assignment should be applied."
}

variable "tenant_id" {
  type        = string
  description = "The ID of the tenant to which the role assignment should be applied."
}

variable "object_id" {
  type        = string
  description = "The ID of the object to which the role assignment should be applied."
}
