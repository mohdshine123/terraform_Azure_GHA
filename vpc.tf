locals {
  resource_group_name = "my-terraform-rg"
  location            = "Central India"
}

# Check if the resource group already exists
data "azurerm_resource_group" "existing_rg" {
  name = local.resource_group_name
}

# Create a Resource Group if it doesn’t exist
resource "azurerm_resource_group" "my-terraform-rg" {
  count    = data.azurerm_resource_group.existing_rg ? 0 : 1
  name     = local.resource_group_name
  location = local.location
}

# Check if the virtual network already exists
data "azurerm_virtual_network" "existing_vnet" {
  count               = data.azurerm_resource_group.existing_rg ? 1 : 0
  name                = "my-terraform-vnet"
  resource_group_name = local.resource_group_name
}

# Check if the subnet already exists
data "azurerm_subnet" "existing_subnet" {
  count                = data.azurerm_resource_group.existing_rg ? 1 : 0
  name                 = "my-terraform-subnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet[0].name
}

# Create a Virtual Network and Subnet conditionally
resource "azurerm_virtual_network" "my-terraform-vnet" {
  count               = data.azurerm_virtual_network.existing_vnet ? 0 : 1
  name                = "my-terraform-vnet"
  location            = azurerm_resource_group.my-terraform-rg[count.index].location
  resource_group_name = azurerm_resource_group.my-terraform-rg[count.index].name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "my-terraform-subnet" {
  count                = data.azurerm_subnet.existing_subnet ? 0 : 1
  name                 = "my-terraform-subnet"
  resource_group_name  = azurerm_resource_group.my-terraform-rg[count.index].name
  virtual_network_name = azurerm_virtual_network.my-terraform-vnet[count.index].name
  address_prefixes     = ["10.0.2.0/24"]
}
