variable "security_rules" {
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = optional(string, "*") # Указал значение по умолчанию
    destination_port_range     = string
    source_address_prefix      = optional(string, "VirtualNetwork") # Более безопасное значение по умолчанию
    destination_address_prefix = optional(string, "VirtualNetwork")
    description                = optional(string, "")
  }))
  description = "Map of security rules with their parameters"
  default = {
    ssh = {
      priority               = 100
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "22"
      description            = "Allow SSH access"
    },
    http = {
      priority               = 110
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "80"
      description            = "Allow HTTP access"
    },
    https = {
      priority               = 120
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      destination_port_range = "443"
      description            = "Allow HTTPS access"
    }
  }
}
