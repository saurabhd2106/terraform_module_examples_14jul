locals {
  prefix = "saurabh"

  location = "eastus"

  address_space = ["10.0.0.0/16"]

  tags = {
    env = "test"
  }

  subnets = {
    public_subnet = {

      address_prefixes = ["10.0.1.0/24"]

    }

    private_subnet = {

      address_prefixes = ["10.0.2.0/24"]

    }

  }

  security_group = ["public_sg", "private_sg"]

  sg_rule = {
    allow_ssh = {
      security_group = "public_sg"

      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"

    }

    allow_80 = {

      security_group = "public_sg"

      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"

    }

  }

  ip_configurations = {
    internal = {
      subnet_id = module.subnets["public_subnet"].subnet.id

      private_ip_address_allocation = "Dynamic"


    }
  }

}

