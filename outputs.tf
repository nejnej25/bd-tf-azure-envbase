output "resource_group_ids" {
  description = "Map of resource group IDs"
  value = {
    for k, v in module.resource_groups :
    k => v.id
  }
}

output "resource_group_names" {
  description = "Map of resource group names"
  value = {
    for k, v in module.resource_groups :
    k => v.name
  }
}

output "virtual_network_ids" {
  description = "Map of virtual network IDs"
  value = {
    for k, v in module.virtual_networks :
    k => v.id
  }
}

output "virtual_network_subnet_ids" {
  description = "Map of subnets IDs in virtual networks"
  value = {
    for k, v in module.virtual_networks :
    k => v.subnet_ids
  }
}
