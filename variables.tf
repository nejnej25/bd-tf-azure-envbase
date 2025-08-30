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
