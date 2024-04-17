terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.28.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstatestoragerafamb"
    container_name       = "terraformstate"
    key                  = "terraformgithub.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

variable "tag_id" {
  type = string
}

resource "azurerm_resource_group" "rg_apputb" {
  name = "rg_apputb" # this is the name on azure
  location = "eastus" # data center location on azure
}

resource "azurerm_container_group" "tf_cg_utb" {
  name                  = "apputb"
  location              = azurerm_resource_group.rg_apputb.location #utilising the resource group
  resource_group_name   = azurerm_resource_group.rg_apputb.name #utilising the resource group

  ip_address_type       = "Public"
  dns_name_label        = "rafaelenrike-apputb" #friendly name we want to give our domain
  os_type               = "Linux"

  # Specify the container information
  container {
    name = "apputb"
    image = "rafaelenrike/apputb:${var.tag_id}"
    cpu = "1"
    memory = "1"

    ports {
        port = 80
        protocol = "TCP"
    }
  }
}