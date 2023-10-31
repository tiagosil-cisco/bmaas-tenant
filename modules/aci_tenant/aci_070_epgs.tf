resource "aci_application_epg" "epg_prod" {

  application_profile_dn = aci_application_profile.ap.id
  name                   = "PROD"
  relation_fv_rs_bd      = aci_bridge_domain.bd_prod.id
}

resource "aci_epg_to_domain" "vmm_domain_PROD" {
  application_epg_dn    = aci_application_epg.epg_prod.id
  tdn                   = data.aci_vmm_domain.aci_vmm_vds.id
  res_imedcy            = "immediate"
  vmm_allow_promiscuous = "accept"
  vmm_forged_transmits  = "accept"
  vmm_mac_changes       = "accept"
}

resource "aci_epg_to_contract" "PROD_TO_L3OUT_prov" {
  application_epg_dn = aci_application_epg.epg_prod.id
  contract_dn        = aci_contract.PROD_TO_L3OUT.id
  contract_type      = "provider"
}
resource "aci_epg_to_contract" "PROD_TO_L3OUT_cons" {
  application_epg_dn = aci_application_epg.epg_prod.id
  contract_dn        = aci_contract.PROD_TO_L3OUT.id
  contract_type      = "consumer"
}

resource "aci_application_epg" "epg_mgmt" {

  application_profile_dn = aci_application_profile.ap.id
  name                   = "MGMT"
  relation_fv_rs_bd      = aci_bridge_domain.bd_mgmt.id
}

resource "aci_epg_to_contract" "MGMT_TO_L3OUT_prov" {
  application_epg_dn = aci_application_epg.epg_mgmt.id
  contract_dn        = aci_contract.MGMT_TO_L3OUT.id
  contract_type      = "provider"
}
resource "aci_epg_to_contract" "MGMT_TO_L3OUT_cons" {
  application_epg_dn = aci_application_epg.epg_mgmt.id
  contract_dn        = aci_contract.MGMT_TO_L3OUT.id
  contract_type      = "consumer"
}

data "aci_physical_domain" "physical_domain" {
  name = var.physical_config.name
}

resource "aci_epg_to_domain" "PROD_to_Physical_domain" {

  application_epg_dn = aci_application_epg.epg_prod.id
  tdn                = data.aci_physical_domain.physical_domain.id

}

resource "aci_epg_to_static_path" "EPG_PROD_VLAN_FI-A-tag" {
  application_epg_dn = aci_application_epg.epg_prod.id
  tdn                = "topology/pod-1/protpaths-${var.physical_config.leaf_a}-${var.physical_config.leaf_b}/pathep-[${var.physical_config.vpc_to_fi_a}]"
  encap              = "vlan-${local.ico_input.prod_network.vlan}"
  mode               = "regular"
}

resource "aci_epg_to_static_path" "EPG_PROD_VLAN_FI-B-tag" {
  application_epg_dn = aci_application_epg.epg_prod.id
  tdn                = "topology/pod-1/protpaths-${var.physical_config.leaf_a}-${var.physical_config.leaf_b}/pathep-[${var.physical_config.vpc_to_fi_b}]"
  encap              = "vlan-${local.ico_input.prod_network.vlan}"
  mode               = "regular"
}

resource "aci_epg_to_domain" "MGMT_to_Physical_domain" {

  application_epg_dn = aci_application_epg.epg_mgmt.id
  tdn                = data.aci_physical_domain.physical_domain.id

}
resource "aci_epg_to_static_path" "EPG_MGMT_VLAN_FI-A-tag" {
  application_epg_dn = aci_application_epg.epg_mgmt.id
  tdn                = "topology/pod-1/protpaths-${var.physical_config.leaf_a}-${var.physical_config.leaf_b}/pathep-[${var.physical_config.vpc_to_fi_a}]"
  encap              = "vlan-${local.ico_input.mgmt_network.vlan}"
  mode               = "regular"
}

resource "aci_epg_to_static_path" "EPG_MGMT_VLAN_FI-B-tag" {
  application_epg_dn = aci_application_epg.epg_mgmt.id
  tdn                = "topology/pod-1/protpaths-${var.physical_config.leaf_a}-${var.physical_config.leaf_b}/pathep-[${var.physical_config.vpc_to_fi_b}]"
  encap              = "vlan-${local.ico_input.mgmt_network.vlan}"
  mode               = "regular"
}
