variable "resource_group" {
  type = string
  default = "rg-terraform-linux-vm"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "linuxVm"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "username" {
  type    = string
  default = "azureuser"
}
