locals {
  name_standard = "${var.environment}-${var.location}"
  common_tags = {
    Terraform_Managed = "true"
    Terraform_Service_Module = "envbase"
    Environment = var.environment
  }
  tags = merge(
    var.tags,
    local.common_tags
  )
}
module "resource_groups" {
  source = "git@github.com:nejnej25/bd-tf-azure-modules.git//azure-resource-group?ref=main"

  for_each = var.use_resource_group ? { for k, v in var.resource_groups : v.name => v } : {}
  rg_name  = "${local.name_standard}-${each.key}"
  location = var.location
  tags     = local.tags
}

module "virtual_networks" {
  source = "git@github.com:nejnej25/bd-tf-azure-modules//azure-network?ref=main"

  for_each    = var.use_virtual_network ? var.virtual_networks : {}
  rg          = module.resource_groups[each.value.rg].name
  location    = var.location
  vnet_name   = "${local.name_standard}-${each.key}"
  vnet_ranges = each.value.vnet_ranges
  subnets     = each.value.subnets
  tags        = local.tags

  subnet_nsg_mapping = { for k, v in each.value.subnets: k => modules.network_security_groups[k].id }
}

module "network_security_groups" {
  source = "git@github.com:nejnej25/bd-tf-azure-modules//azure-network-security-group?ref=main"

  for_each       = var.use_network_security_group ? var.network_security_groups : {}
  rg             = module.resource_groups[each.value.rg].name
  location       = var.location
  nsg_name       = "${local.name_standard}-${each.key}"
  inbound_rules  = each.value.inbound_rules
  outbound_rules = each.value.outbound_rules
  tags           = local.tags
}

module "container_registries" {
  source = "git@github.com:nejnej25/bd-tf-azure-modules//azure-container-registry?ref=main"

  for_each                      = var.use_container_registry ? var.container_registries : {}
  rg                            = module.resource_groups[each.value.rg].name
  acr_name                      = "${var.environment}${var.location}${each.key}"
  location                      = var.location
  sku                           = each.value.sku
  public_network_access_enabled = each.value.public_network_access_enabled
  admin_enabled                 = each.value.admin_enabled
  zone_redundancy_enabled       = each.value.zone_redundancy_enabled
  tags                          = local.tags
}
