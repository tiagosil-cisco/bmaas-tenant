resource "aci_application_profile" "ap" {
  tenant_dn = aci_tenant.tenants.id
  name      = local.ico_input.project_name.name
}