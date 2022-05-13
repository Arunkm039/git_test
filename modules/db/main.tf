resource "azurerm_sql_server" "sql" {
  name                         = "appdemo123"
  resource_group_name          = var.rg_name
  location                     = "eastus2"
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_pass

  tags = {
    environment = "production"
  }
}


resource "azurerm_sql_database" "sqldb" {
  name                = "appdemo"
  resource_group_name = var.rg_name
  location            = "eastus2"
  server_name         = azurerm_sql_server.sql.name
}