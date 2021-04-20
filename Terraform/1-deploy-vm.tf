# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

variable "location" {
  type    = string
  default = "westeurope"
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "rg_test" {
  name     = "rg-test-terraform"
  location = var.location
}

# Create virtual network
resource "azurerm_virtual_network" "vnet_test" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_test.name
}

# Create subnet
resource "azurerm_subnet" "subnet_test" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.rg_test.name
  virtual_network_name = azurerm_virtual_network.vnet_test.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "pip_test" {
  name                = "myPublicIP"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_test.name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg_test" {
  name                = "myNetworkSecurityGroup"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_test.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "vnic_test" {
  name                = "myNIC"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_test.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.subnet_test.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_test.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.vnic_test.id
  network_security_group_id = azurerm_network_security_group.nsg_test.id
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg_test.name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "sa_test" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = azurerm_resource_group.rg_test.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"


}

# Create an SSH key
resource "tls_private_key" "ssh_key_test" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Write SSH private key to local file
resource "local_file" "ssh_key_test_private_key" {
  content         = tls_private_key.ssh_key_test.private_key_pem
  filename        = "ssh_key_test.pem"
  file_permission = "0600"
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm_test" {
  name                  = "myVM"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg_test.name
  network_interface_ids = [azurerm_network_interface.vnic_test.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "myvm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.ssh_key_test.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.sa_test.primary_blob_endpoint
  }

}

output "connection_string" {
  description = "Use this string to connect via SSH to the newly created vm"
  value = "ssh -o 'IdentitiesOnly=yes' -i ./${local_file.ssh_key_test_private_key.filename} azureuser@${azurerm_public_ip.pip_test.ip_address}"
}