# 3. Resource Group Name
variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  
}

# 4. Resource Group Location
variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string  

}

# 5. Virtual Network Name
variable "virtual_network_name" {
  description = "Virtual Network Name"
  type = string
    
}
# 6. Subnet Name: Assign When Prompted using CLI
variable "subnet_name" {
  description = "Virtual Network Subnet Name"
  type = string
    
}

# 7. Virtual Network address_space
variable "virtual_network_address_space" {
  description = "Virtual Network Address Space"
  type = list(string)
  default = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
}

# 8. Public IP SKU
/* variable "public_ip_sku" {
  description = "Azure Public IP Address SKU"
  type = map(string)
  default = {
    "eastus" = "Basic",
    "eastus2" = "Standard"
  }
} */


/* variable "network_security_group_name" {
  description = "network security group Name"
  type = string   
} */

variable "subnet_address" {
  description = "subnet Address Space"
  type = list(string)
  
}



