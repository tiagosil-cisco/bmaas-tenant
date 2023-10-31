resource "aci_tenant" "tenants" {
  name = "bmaas-${local.ico_input.project_name.name}"
}