# Set the Azure Provider source and version being used
terraform {

  required_version = ">= 0.12"

  backend "azurerm" {
  use_oidc = true
    # Get backend configuration from config/backend-*.conf  # Initialise using: terraform init -backend-config=config/backend-dev.conf
  }
}

provider "azurerm" {
  use_oidc = true
  features {}
  skip_provider_registration = true
}
