data "aci_l3_domain_profile" "l3_domain" {
  name = local.aci_l3domain
}

resource "aci_l3_outside" "L3OUT-BGP" {
  tenant_dn                    = aci_tenant.tenants.id
  name                         = "L3OUT-BGP"
  relation_l3ext_rs_ectx       = aci_vrf.vrfs.id
  relation_l3ext_rs_l3_dom_att = data.aci_l3_domain_profile.l3_domain.id
}



resource "aci_external_network_instance_profile" "external_network_instance_profile" {
  l3_outside_dn       = aci_l3_outside.L3OUT-BGP.id
  name                = "ExtEPG"
  match_t             = "All"
  pref_gr_memb        = "exclude"
  relation_fv_rs_cons = [aci_contract.L3OUT.id, aci_contract.PROD_TO_L3OUT.id, aci_contract.MGMT_TO_L3OUT.id]
  relation_fv_rs_prov = [aci_contract.L3OUT.id, aci_contract.PROD_TO_L3OUT.id, aci_contract.MGMT_TO_L3OUT.id]

}

resource "aci_l3_ext_subnet" "EXT_SUBNET_DEFAULT" {
  external_network_instance_profile_dn = aci_external_network_instance_profile.external_network_instance_profile.id
  ip                                   = "0.0.0.0/0"
}

resource "aci_logical_node_profile" "node_profile" {
  l3_outside_dn = aci_l3_outside.L3OUT-BGP.id
  name          = "BMaaS_node_profile"

}

resource "aci_l3out_bgp_protocol_profile" "bgp_protocol_profile" {
  logical_node_profile_dn = aci_logical_node_profile.node_profile.id
}

resource "aci_l3out_bgp_external_policy" "bgp_ext_pol" {
  l3_outside_dn = aci_l3_outside.L3OUT-BGP.id
}

resource "aci_logical_node_to_fabric_node" "Leaf_a" {
  logical_node_profile_dn = aci_logical_node_profile.node_profile.id
  tdn                     = "topology/pod-1/node-${var.l3out_config.leaf_a}"
  annotation              = "annotation"
  config_issues           = "none"
  rtr_id                  = var.l3out_config.leaf_a_router_id
  rtr_id_loop_back        = "no"
}

resource "aci_logical_node_to_fabric_node" "Leaf_b" {
  logical_node_profile_dn = aci_logical_node_profile.node_profile.id
  tdn                     = "topology/pod-1/node-${var.l3out_config.leaf_b}"
  annotation              = "annotation"
  config_issues           = "none"
  rtr_id                  = var.l3out_config.leaf_b_router_id
  rtr_id_loop_back        = "no"
}

resource "aci_logical_interface_profile" "logical_interface_profile" {
  logical_node_profile_dn = aci_logical_node_profile.node_profile.id
  description             = "Sample logical interface profile"
  name                    = "L3OUT-to-CORE"
}

resource "aci_l3out_path_attachment" "L3OUT_Path_Attachment" {
  logical_interface_profile_dn = aci_logical_interface_profile.logical_interface_profile.id
  target_dn                    = "topology/pod-1/protpaths-${var.l3out_config.leaf_a}-${var.l3out_config.leaf_b}/pathep-[${local.vpc_interface_policy_group}]"
  if_inst_t                    = "ext-svi"
  description                  = "from terraform"
  encap                        = "vlan-${local.ico_input.l3out_network.vlan}"
  encap_scope                  = "local"
  mode                         = "regular"
  mtu                          = "inherit"

}

resource "aci_l3out_vpc_member" "L3OUT_SVI_A" {
  leaf_port_dn = aci_l3out_path_attachment.L3OUT_Path_Attachment.id
  side         = "A"
  addr         = join("/", [cidrhost(local.ico_input.l3out_network.subnet, 1), split("/", local.ico_input.l3out_network.subnet)[1]])
}
resource "aci_l3out_vpc_member" "L3OUT_SVI_B" {
  leaf_port_dn = aci_l3out_path_attachment.L3OUT_Path_Attachment.id
  side         = "B"
  addr         = join("/", [cidrhost(local.ico_input.l3out_network.subnet, 2), split("/", local.ico_input.l3out_network.subnet)[1]])
}

resource "aci_bgp_peer_connectivity_profile" "BGP-PEER1" {
  parent_dn   = aci_l3out_path_attachment.L3OUT_Path_Attachment.id
  addr        = cidrhost(local.ico_input.l3out_network.subnet, 5)
  addr_t_ctrl = ["af-ucast"]
  as_number   = local.bgp_remote_as
  local_asn   = local.bgp_local_as
  admin_state = "enabled"
}

resource "aci_bgp_peer_connectivity_profile" "BGP-PEER2" {
  parent_dn   = aci_l3out_path_attachment.L3OUT_Path_Attachment.id
  addr        = cidrhost(local.ico_input.l3out_network.subnet, 6)
  addr_t_ctrl = ["af-ucast"]
  as_number   = local.bgp_remote_as
  local_asn   = local.bgp_local_as
  admin_state = "enabled"
}
