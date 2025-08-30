locals {
  name_standard="${var.environment}-${var.location}"
}
module "resource_groups" {
  source = "git@github.com:nejnej25/bd-tf-azure-modules//azure-resource-group"

  for_each = var.use_resource_group ? { for k, v in var.resource_groups : v.name => v } : {}
  rg_name  = "${local.name_standard}-${each.key}"
  region   = var.location
  tags     = var.tags
}

#module "virtual_networks" {
#  source = "git@github.com:nejnej25/bd-tf-azure-modules//azure-network"
#
#  for_each    = var.use_virtual_network ? var.virtual_networks : {}
#  rg          = module.resource_groups[each.value.rg].name
#  region      = var.location
#  vnet_name   = "${var.environment}-${each.key}"
#  vnet_ranges = each.value.vnet_ranges
#  subnets     = each.value.subnets
#}
