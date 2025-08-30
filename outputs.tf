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
