locals {
  resource_group_name  = "myapp-rg"
  virtual_network_name = "my-terraform-vnet"
  subnet_name          = "my-terraform-subnet"
  location             = "Central India"
  env                  = "dev"

common_tags = {
    environment = "dev"
    owner       = "team"
    project     = "my-project"
  }

}


