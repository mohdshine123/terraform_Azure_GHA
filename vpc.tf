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
resource "azurerm_resource_group" "existing_rg" {
  
  name     = local.resource_group_name
  location = local.location
}

