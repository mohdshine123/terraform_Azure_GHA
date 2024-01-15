locals {
  rgnamedev            =  "myapp-rgnew"
  #resource_group_name  = "myapp-rg"
  virtual_network_name = "my-terraform-vnet"
  subnet_name          = "my-terraform-subnet"
  location             = "centralindia"
  env                  = "dev-testnew"
  sa_name              = "teststorageforlab"
  container_name       = "testcontainer"
  owner               = "nectmi"
  service             = "infra"
  component           = "nectmi"
  costCentre          = "nectmi"
  createdBy           = "terraform"
  ai_frontend_name    = "nectmi"

common_tags = {
    location    = local.location
    environment = local.env
    owner       = local.owner
    service     = local.service
    component   = local.component
    costCentre  = local.costCentre
    taggingVersion = "0.1.0"
    expiryDate  = "3000-01-01T00:00:00Z"
    createdBy   = local.createdBy
}
}


