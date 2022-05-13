

# Create Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address_space
  location            = var.rg_location
  resource_group_name = var.rg_name
}




