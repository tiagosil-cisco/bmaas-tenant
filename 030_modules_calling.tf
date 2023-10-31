
module "aci_tenant" {

  source = "./modules/aci_tenant"

  credentials  = var.credentials
  project_name = local.project_name
  aci_bgp_asn  = local.aci_bgp_asn
  core_bgp_asn = local.core_bgp_asn

}


module "nxos" {
  source = "./modules/nxos"

  aci_bgp_asn  = local.aci_bgp_asn
  core_bgp_asn = local.core_bgp_asn

}