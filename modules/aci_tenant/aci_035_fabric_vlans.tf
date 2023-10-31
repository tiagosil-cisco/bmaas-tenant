data "aci_vlan_pool" "l3out_vlans" {
  name       = local.aci_vlan_pool_l3out
  alloc_mode = "static"
}

data "aci_vlan_pool" "fabric_vlans" {
  name       = local.aci_vlan_pool_phys_domain
  alloc_mode = "static"
}

resource "aci_ranges" "prod1" {
  vlan_pool_dn = data.aci_vlan_pool.fabric_vlans.id
  from         = "vlan-${local.ico_input.prod_network.vlan}"
  to           = "vlan-${local.ico_input.prod_network.vlan}"
  alloc_mode   = "inherit"
  role         = "external"
}
resource "aci_ranges" "mgmt1" {
  vlan_pool_dn = data.aci_vlan_pool.fabric_vlans.id
  from         = "vlan-${local.ico_input.mgmt_network.vlan}"
  to           = "vlan-${local.ico_input.mgmt_network.vlan}"
  alloc_mode   = "inherit"
  role         = "external"
}

resource "aci_ranges" "l3out1" {
  vlan_pool_dn = data.aci_vlan_pool.l3out_vlans.id
  from         = "vlan-${local.ico_input.l3out_network.vlan}"
  to           = "vlan-${local.ico_input.l3out_network.vlan}"
  alloc_mode   = "inherit"
  role         = "external"
}