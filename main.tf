# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
  # Terraform State Storage to Azure Storage Container
  backend "azurerm" {
    resource_group_name   = "akm-rg"
    storage_account_name  = "tfstatedemo123"
    container_name        = "tfstatefiles"
    key                   = "terraform.tfstate"
  } 

}



# Provider Block
provider "azurerm" {
  features {}
}

# Random String Resource
resource "random_string" "myrandom" {
  length  = 6
  upper   = false
  special = false
  number  = false
}

# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "myrg" {
  name     = var.resource_group_name
  #name = "${local.resource_name_prefix}-${var.resource_group_name}"
  location = var.resoure_group_location
}



module "vnet" {
  source = "./modules/vnet"

  rg_name = azurerm_resource_group.myrg.name
  rg_location = azurerm_resource_group.myrg.location
  virtual_network_name = var.virtual_network_name
  #virtual_network_name = "${local.resource_name_prefix}-${var.virtual_network_name}"
  virtual_network_address_space = var.virtual_network_address_space
      
}




module "subnet" {
  source = "./modules/subnet"

  subnet_name = var.subnet_name
  #subnet_name = "${local.resource_name_prefix}-${var.subnet_name}"
  rg_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefix = var.subnet_address
  depends_on = [
    module.vnet
  ]
}


module "nsg" {
  source = "./modules/nsg"

  rg_name = azurerm_resource_group.myrg.name
  rg_location = azurerm_resource_group.myrg.location

}



module "db" {
  source = "./modules/db"

   rg_name = azurerm_resource_group.myrg.name  
}

resource "azurerm_subnet_network_security_group_association" "nsgassociate" {
  depends_on = [ module.nsg]
  subnet_id  = module.subnet.subnet_id
  network_security_group_id = module.nsg.nsg_id
}


# Create Public IP Address
resource "azurerm_public_ip" "mypublicip" {  
  #for_each = toset(["public", "private" ])
  # count = 2
  name                = "myip"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  allocation_method   = "Static"
  domain_name_label   = "app1-myip-${random_string.myrandom.id}"
  tags = {
    environment = "Dev"
  }
}

# Create Network Interface
/* resource "azurerm_network_interface" "myvmnic" {
 # for_each = toset(["vm1", "vm2"]) 
  name                = "vmnic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.subnet.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypublicip.id
  }
} */


