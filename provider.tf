terraform {

  required_version = ">=1.2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.22"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "=2.21.0"
    }
    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = ">= 0.0.7"
    }
  }
}