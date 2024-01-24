terraform {
  required_version = ">=1.5.6"
  required_providers {
    polaris = {
      source  = "rubrikinc/polaris"
      version = "=0.8.0-beta.8"
    }
  }
}

provider "polaris" {
  credentials = var.rsc_credentials
}