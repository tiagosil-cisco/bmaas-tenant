
module "aci_tenant" {

  source = "./modules/aci_tenant"

  credentials  = var.credentials
  project_name = local.project_name

}


module "nxos" {
  source = "./modules/nxos"

}