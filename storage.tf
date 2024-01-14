resource "azurerm_storage_account" "this" {
  name                              = "${local.sa_name}"
  resource_group_name               = "${local.rgnamedev}"
  location                          = "${local.location}"
  account_tier                      = "Standard"
  account_kind                      = "StorageV2"
  account_replication_type          = "LRS"
  enable_blob_encryption            = "true"
  enable_file_encryption            = "true"
  enable_advanced_threat_protection = "true"
  #tags                             = "${module.tag.tags}"
  tags                              = local.common_tags
}

resource "azurerm_storage_container" "this" {
  name                  = "${local.container_name}"
  storage_account_name  = "${azurerm_storage_account.this.name}"
  container_access_type = "private"
}

output "account_name" {
  value = "${azurerm_storage_account.this.name}"
}

output "account_key" {
  value = "${azurerm_storage_account.this.primary_access_key}"
  sensitive   = true
}

output "container_name" {
  value = "${azurerm_storage_container.this.name}"
}
