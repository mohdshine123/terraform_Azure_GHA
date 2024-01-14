locals {
  resource_group_name  = "myapp-rg"
  virtual_network_name = "my-terraform-vnet"
  subnet_name          = "my-terraform-subnet"
  location             = "centralindia"
  env                  = "dev-test"

common_tags = {
    environment = local.env
    owner       = "team"
    project     = "my-project"
  }

}


