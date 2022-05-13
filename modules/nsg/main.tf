# Create Security group
resource "azurerm_network_security_group" "mysg" {
  name                = "TestSecurityGroup1"
  location            = var.rg_location
  resource_group_name = var.rg_name 
 
   tags = {
    environment = "Dev"
  }
}

resource "azurerm_network_security_rule" "nsgrule" {
  name                        = "sgrule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.mysg.name
}

/* resource "azurerm_subnet_network_security_group_association" "nsg_associate" {
  depends_on = [ azurerm_network_security_rule.nsgrule] # Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created - Azure Provider Bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/354  
  subnet_id                 = module.subnet.azurerm_subnet.mysubnet.id
} */