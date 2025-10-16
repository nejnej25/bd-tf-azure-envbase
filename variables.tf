variable "location" {
  description = "Location where to deploy resources"
  type        = string
}

variable "environment" {
  description = "Environment where to deploy resources"
  type        = string
}

variable "tags" {
  description = "Additional tags to resources"
  type        = map(string)
  default     = null
}

variable "use_resource_group" {
  description = "Enable/disable use of resource group module"
  type        = bool
  default     = false
}

variable "resource_groups" {
  description = "Resource groups definitions"
  type = list(object({
    name = string
  }))
}

variable "use_virtual_network" {
  description = "Enable/disable use of virtual network module"
  type        = bool
  default     = false
}

variable "virtual_networks" {
  description = "Virtual network definitions"
  type = map(object({
    rg          = string
    vnet_ranges = list(string)
    subnets = optional(map(object({
      prefix_enabled     = optional(bool, true)
      subnet_range       = string
      service_endpoints  = optional(list(string), [])
      delegation_enabled = optional(bool, false)
      delegation_name    = optional(string, "")
      delegation_action  = optional(list(string), [])
    })), {})
  }))
}

variable "use_network_security_group" {
  description = "Enable/disable use of network security group module"
  type        = bool
  default     = false
}

variable "network_security_groups" {
  description = "Network security group definitions"
  type = map(object({
    rg = string
    inbound_rules = optional(map(object({
      enabled                      = bool
      priority                     = number
      protocol                     = string
      source_port_ranges           = list(string)
      source_port_range            = string
      source_address_prefixes      = list(string)
      source_address_prefix        = string
      destination_port_ranges      = list(string)
      destination_port_range       = string
      destination_address_prefixes = list(string)
      destination_address_prefix   = string
      access                       = string
    })), {})
    outbound_rules = optional(map(object({
      enabled                      = bool
      priority                     = number
      protocol                     = string
      source_port_ranges           = list(string)
      source_port_range            = string
      source_address_prefixes      = list(string)
      source_address_prefix        = string
      destination_port_ranges      = list(string)
      destination_port_range       = string
      destination_address_prefixes = list(string)
      destination_address_prefix   = string
      access                       = string
    })), {})
  }))
  default = {}
}

variable "use_container_registry" {
  description = "Enable/disable use of container registry module"
  type        = bool
  default     = false
}

variable "container_registries" {
  description = "Container registry definitions"
  type = map(object({
    rg                            = string
    sku                           = string
    public_network_access_enabled = bool
    admin_enabled                 = bool
    zone_redundancy_enabled       = bool
  }))
}
