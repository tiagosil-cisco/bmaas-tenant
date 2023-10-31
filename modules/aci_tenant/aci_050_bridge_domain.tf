resource "aci_bridge_domain" "bd_prod" {
  tenant_dn                = aci_tenant.tenants.id
  relation_fv_rs_ctx       = aci_vrf.vrfs.id
  name                     = "BD_PROD"
  relation_fv_rs_bd_to_out = [aci_l3_outside.L3OUT-BGP.id]
}


resource "aci_subnet" "bd_prod_subnet" {
  parent_dn = aci_bridge_domain.bd_prod.id
  ip        = join("/", [cidrhost(local.ico_input.prod_network.subnet, 1), split("/", local.ico_input.prod_network.subnet)[1]])
  scope     = ["public", "shared"]
  virtual   = "yes"
  preferred = "yes"
}


resource "aci_bridge_domain" "bd_mgmt" {
  tenant_dn                = aci_tenant.tenants.id
  relation_fv_rs_ctx       = aci_vrf.vrfs.id
  name                     = "BD_MGMT"
  relation_fv_rs_bd_to_out = [aci_l3_outside.L3OUT-BGP.id]
}


resource "aci_subnet" "bd_mgmt_subnet" {
  parent_dn = aci_bridge_domain.bd_mgmt.id
  ip        = join("/", [cidrhost(local.ico_input.mgmt_network.subnet, 1), split("/", local.ico_input.mgmt_network.subnet)[1]])
  scope     = ["public", "shared"]
  virtual   = "yes"
  preferred = "yes"
}
