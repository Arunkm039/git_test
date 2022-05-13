# 3. Resource Group Name
variable "rg_name" {
  description = "Resource Group Name"
  type = string
  default = "dbrg"
}


variable "admin_login" {
  description = "sql login name"
  type = string
  default = "akm123"

  }


variable "admin_pass" {
  description = "sql login pass"
  type = string
  default = "Arunkm@12345"

  }