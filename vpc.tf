# Create a Resource Group if it doesn’t exist
resource "azurerm_resource_group" "tfexample" {
  name     = "my-terraform-rg"
  location = "Central India"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "tfexample" {
  name                = "my-terraform-vnet"
  location            = azurerm_resource_group.tfexample.location
  resource_group_name = azurerm_resource_group.tfexample.name
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet in the Virtual Network
resource "azurerm_subnet" "tfexample" {
  name                 = "my-terraform-subnet"
  resource_group_name  = azurerm_resource_group.tfexample.name
  virtual_network_name = azurerm_virtual_network.tfexample.name
  address_prefixes     = ["10.0.2.0/24"]
}
