locals {
  resource_group_name  = "my-terraform-rg"
  virtual_network_name = "my-terraform-vnet"
  subnet_name          = "my-terraform-subnet"
  location             = "Central India"
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
  name                = local.virtual_network_name
  resource_group_name = data.azurerm_resource_group.existing_rg[0].name
}

# Check if the subnet already exists
data "azurerm_subnet" "existing_subnet" {
  name                 = local.subnet_name
  resource_group_name  = data.azurerm_resource_group.existing_rg[0].name
}



# Create a Virtual Network and Subnet conditionally
resource "azurerm_virtual_network" "my-terraform-vnet" {
  count               = length(data.azurerm_virtual_network.existing_vnet) > 0 ? 0 : 1
  name                = local.virtual_network_name
  location            = azurerm_resource_group.my-terraform-rg[0].location
  resource_group_name = azurerm_resource_group.my-terraform-rg[0].name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "my-terraform-subnet" {
  count                = length(data.azurerm_subnet.existing_subnet) > 0 ? 0 : 1
  name                 = local.subnet_name
  resource_group_name  = azurerm_resource_group.my-terraform-rg[0].name
  virtual_network_name = azurerm_virtual_network.my-terraform-vnet[0].name
  address_prefixes     = ["10.0.2.0/24"]
}
