module "rg" {

  source = "../azure_modules_14jul/resource_group"

  name = "${local.prefix}-rg"

  location = local.location

  tags = local.tags

}

module "vnet" {

  source = "../azure_modules_14jul/azurerm_virtual_networks"

  name = "${local.prefix}-vnet"

  resource_group_name = module.rg.resource_group.name

  location = local.location

  address_space = local.address_space

  tags = local.tags

}

module "subnets" {

  for_each = local.subnets

  source = "../azure_modules_14jul/azurerm_subnets"

  resource_group_name = module.rg.resource_group.name

  name = each.key

  vnet_name = module.vnet.virtual_network.name

  address_prefixes = each.value.address_prefixes

}

module "security_group" {

  for_each = toset(local.security_group)

  source = "../azure_modules_14jul/azurerm_network_security_group"

  resource_group_name = module.rg.resource_group.name

  location = local.location

  name = each.value

}

module "security_group_rule" {

  source = "../azure_modules_14jul/azurerm_network_security_rule"

  for_each = local.sg_rule

  resource_group_name = module.rg.resource_group.name

  name                        = each.key
  network_security_group_name = each.value.security_group

  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix

}

module "nic" {

    source = "../azure_modules_14jul/azurerm_network_interface"

    resource_group_name = module.rg.resource_group.name

    location = local.location

    name = "${local.prefix}-vnet"

    enable_ip_forwarding = false

    enable_accelerated_networking = false

    ip_configurations = local.ip_configurations

}

module "public_ip" {

  source = "../azure_modules_14jul/azurerm_public_ip"

  resource_group_name = module.rg.resource_group.name

  location = local.location

  name = "${local.prefix}-public-ip"

  sku = "Basic"

  allocation_method = "Dynamic"

}

