output "nsgrule_name" {
  value = azurerm_network_security_rule.nsgrule.name
}

output "nsg_id" {
  value = azurerm_network_security_group.mysg.id
}