# Username and password
variable "admin_username" {
  type = string
  description = "Administrator user name for virtual machine"
}

variable "admin_password" {
  type = string
  description = "Password must meet Azure complexity requirements"
}

# Location
variable "location" {
  description = "Region to build into"
  default     = "westus2"
}

# Resource group name
variable "rg" {
  description = "Resource group name"
  default     = "TFResourceGroup"
}

# VNet
variable "cidr" {
  description = "VNet CIDR"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# Virtual machines
variable "app_vm" {
  description = "Name of app VMs"
  type        = list(string)
  default     = ["App1SRV", "App2SRV", "App3SRV"]
}

variable "db_vm" {
  description = "Name of db VMs"
  type        = list(string)
  default     = ["DB1SRV", "DB2SRV", "DB3SRV"]
}
