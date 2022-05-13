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