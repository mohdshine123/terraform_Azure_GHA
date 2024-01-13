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
  for_each = data.azurerm_resource_group.existing_rg ? {} : { "default" = local.resource_group_name }

  name     = each.value
  location = local.location
}

# Check if the virtual network already exists
data "azurerm_virtual_network" "existing_vnet" {
  for_each            = data.azurerm_resource_group.existing_rg ? {} : { "default" = local.virtual_network_name }
  name                = each.value
  resource_group_name = azurerm_resource_group.my-terraform-rg[each.key].name
}

# Create a Virtual Network conditionally
resource "azurerm_virtual_network" "my-terraform-vnet" {
  for_each = data.azurerm_virtual_network.existing_vnet ? {} : { "default" = local.virtual_network_name }

  name                = each.value
  location            = azurerm_resource_group.my-terraform-rg[each.key].location
  resource_group_name = azurerm_resource_group.my-terraform-rg[each.key].name
  address_space       = ["10.0.0.0/16"]
}

# Check if the subnet already exists
data "azurerm_subnet" "existing_subnet" {
  for_each            = data.azurerm_virtual_network.existing_vnet ? {} : { "default" = local.subnet_name }
  name                = each.value
  resource_group_name = azurerm_resource_group.my-terraform-rg[each.key].name
  virtual_network_name = azurerm_virtual_network.my-terraform-vnet[each.key].name
}

# Create a Subnet conditionally
resource "azurerm_subnet" "my-terraform-subnet" {
  for_each            = data.azurerm_subnet.existing_subnet ? {} : { "default" = local.subnet_name }

  name                 = each.value
  resource_group_name  = azurerm_resource_group.my-terraform-rg[each.key].name
  virtual_network_name = azurerm_virtual_network.my-terraform-vnet[each.key].name
  address_prefixes     = ["10.0.2.0/24"]
}
