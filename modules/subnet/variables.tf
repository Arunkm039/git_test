# Resource Group Name
variable "subnet_name" {
  description = "subnet Name"
  type = string
  default = "mysub1"
}

# Resource Group Name
variable "rg_name" {
  description = "Resource Group Name"
  type = string
  
}
# Resource Group Location
variable "virtual_network_name" {
  description = "virtual network name"
  type = string  
}

# 7. Virtual Network address_space
variable "address_prefix" {
  description = "Virtual Network Address Space"
  type = list(string)
  default = ["10.0.2.0/24"]
}