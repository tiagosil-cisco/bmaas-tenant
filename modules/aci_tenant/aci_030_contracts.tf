resource "aci_filter" "match_all" {
  tenant_dn = aci_tenant.tenants.id
  name      = "match_all"
}

resource "aci_filter_entry" "match_all" {
  name      = "match_all"
  filter_dn = aci_filter.match_all.id
  ether_t   = "ip"
  stateful  = "yes"
}


resource "aci_contract" "L3OUT" {
  tenant_dn = aci_tenant.tenants.id
  name      = "L3OUT"
  scope     = "tenant"
}

resource "aci_contract_subject" "L3OUT_allow_all" {
  contract_dn                  = aci_contract.L3OUT.id
  name                         = "allow_all"
  relation_vz_rs_subj_filt_att = [aci_filter.match_all.id]
}

resource "aci_contract" "PROD_TO_L3OUT" {
  tenant_dn = aci_tenant.tenants.id
  name      = "PROD_TO_L3OUT"
  scope     = "tenant"
}


resource "aci_contract_subject" "PROD_allow_all" {
  contract_dn                  = aci_contract.PROD_TO_L3OUT.id
  name                         = "allow_all"
  relation_vz_rs_subj_filt_att = [aci_filter.match_all.id]
}

resource "aci_contract" "MGMT_TO_L3OUT" {
  tenant_dn = aci_tenant.tenants.id
  name      = "MGMT_TO_L3OUT"
  scope     = "tenant"
}


resource "aci_contract_subject" "MGMT_allow_all" {
  contract_dn                  = aci_contract.MGMT_TO_L3OUT.id
  name                         = "allow_all"
  relation_vz_rs_subj_filt_att = [aci_filter.match_all.id]
}
