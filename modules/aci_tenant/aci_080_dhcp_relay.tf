resource "aci_dhcp_relay_policy" "DHCP_RELAY" {

  tenant_dn  = aci_tenant.tenants.id
  name       = "DHCP_RELAY"
  mode       = "visible"
  name_alias = "alias_example"
  owner      = "tenant"
  relation_dhcp_rs_prov {
    addr = "10.0.10.102"
    tdn  = aci_external_network_instance_profile.external_network_instance_profile.id
  }

}

resource "aci_bd_dhcp_label" "bd_PROD_dhcp_label" {
  bridge_domain_dn = aci_bridge_domain.bd_prod.id
  name             = "DHCP_RELAY"
  owner            = "tenant"

}
