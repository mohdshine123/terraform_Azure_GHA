locals {
  resource_group_name = "my-terraform-rg"
  location            = "Central India"
}

# Check if the resource group already exists
data "azurerm_resource_group" "my-terraform-rg" {
  name = local.resource_group_name
}


# Create a Resource Group if it doesn’t exist
resource "azurerm_resource_group" "my-terraform-rg" {
  count    = data.azurerm_resource_group.my-terraform-rg ? 0 : 1
  name     = "my-terraform-rg"
  location = "Central India"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "my-terraform-vnet" {
  name                = "my-terraform-vnet"
  location            = azurerm_resource_group.my-terraform-rg.location
  resource_group_name = azurerm_resource_group.my-terraform-rg.name
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet in the Virtual Network
resource "azurerm_subnet" "my-terraform-subnet" {
  name                 = "my-terraform-subnet"
  resource_group_name  = azurerm_resource_group.my-terraform-rg.name
  virtual_network_name = azurerm_virtual_network.my-terraform-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
