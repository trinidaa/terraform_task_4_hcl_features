variable "prefix" {
  type    = string
  default = "task4"
}

variable "subscription_id" {
  type      = string
  default   = "9c2e0e5d-9337-4855-af79-231071eb6983"
  sensitive = true
}

variable "admin_username" {
  type      = string
  default   = "testadmin"
  sensitive = true
}

variable "admin_password" {
  type      = string
  default   = "Password1234!"
  sensitive = true
}

variable "hostname" {
  type    = string
  default = "NG-host"
}

variable "is_prod" {
  type    = bool
  default = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
variable "prod_vm" {
  type    = number
  default = 4
  validation {
    condition     = var.prod_vm >= 1 && var.prod_vm <= 6
    error_message = "Production VM count must be between 1 and 6."
  }
}