# Set the Azure Provider source and version being used
terraform {

  required_version = ">= 0.12"

  backend "azurerm" {
    # Get backend configuration from config/backend-*.conf  # Initialise using: terraform init -backend-config=config/backend-dev.conf
  }
}

provider "azurerm" {
  #version = "=1.44.0"

  #tenant_id                   = "${var.service_principal["tenant_id"]}"
  #subscription_id             = "${var.service_principal["subscription_id"]}"
  #client_id                   = "${var.service_principal["client_id"]}"
  # client_secret               = "${var.service_principal["client_secret"]}"
  #client_certificate_path     = "${var.service_principal["client_certificate_path"]}"
  #client_certificate_password = "${var.service_principal["client_certificate_password"]}"

  features {}
  skip_provider_registration = true
}
