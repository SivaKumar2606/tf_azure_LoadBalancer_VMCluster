
# Configure the Microsoft Azure Provider

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
    client_id          = "${var.access_key}"
    client_secret      = "${var.secret_key}"
    subscription_id    = "${var.sub_id}"
    tenant_id          = "${var.tenant_id}"
    features {}
}
