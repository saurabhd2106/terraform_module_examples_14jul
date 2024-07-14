module "rg" {

    source = "../Azure/resource_group"

    name = "${local.prefix}-rg"

    location = "eastus"

    tags = {
        env = "test"
    }
  
}

output "rg_id" {

    value = module.rg.resource_group_id
  
}