# 3. Resource Group Name
variable "rg_name" {
  description = "Resource Group Name"
  type = string
  default = "myrg1"
}
# 4. Resource Group Location
variable "rg_location" {
  description = "Resource Group Location"
  type = string
  default = "East US"
}
# 5. Virtual Network Name
variable "virtual_network_name" {
  description = "Virtual Network Name"
  type = string  
}

# 7. Virtual Network address_space
variable "virtual_network_address_space" {
  description = "Virtual Network Address Space"
  type = list(string)
  default = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
}

