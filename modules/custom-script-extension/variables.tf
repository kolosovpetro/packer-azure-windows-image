variable "custom_script_extension_file_name" {
  type        = string
  description = "The name of the file to be downloaded from the storage account"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account"
}

variable "storage_container_name" {
  type        = string
  description = "The name of the storage container"
}

variable "custom_script_extension_absolute_path" {
  type        = string
  description = "The absolute path of the file to be downloaded from the storage account"
}

variable "extension_name" {
  type        = string
  description = "The name of the extension"
}

variable "virtual_machine_id" {
  type        = string
  description = "The id of the virtual machine"
}
