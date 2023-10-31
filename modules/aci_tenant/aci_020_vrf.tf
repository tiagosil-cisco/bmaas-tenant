resource "aci_vrf" "vrfs" {
  tenant_dn = aci_tenant.tenants.id
  name      = var.project_name
}