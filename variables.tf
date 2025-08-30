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

variable "use_storage_account" {
  description = "Enable/disable use of storage account module"
  type        = bool
  default     = false
}

variable "storage_accounts" {
  description = "Storage account definitions"
  type = map(object({
    rg                         = string
    account_tier               = optional(string, "Standard")
    replication_type           = optional(string, "LRS")
    access_tier                = optional(string, "Hot")
    enable_https_traffic       = optional(bool, true)
    min_tls_version            = optional(string, "TLS1_2")
    blob_soft_delete_days      = optional(number, 7)
    container_soft_delete_days = optional(number, 7)
    is_hns_enabled             = optional(bool, false)
    network_rules = optional(object({
      default_action             = optional(string, "Deny")
      bypass                     = optional(list(string), ["AzureServices"])
      ip_rules                   = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string), [])
    }), {})
    containers = optional(map(object({
      name                  = string
      container_access_type = optional(string, "private")
      metadata              = optional(map(string), {})
    })), {})
  }))
  default = {}
}