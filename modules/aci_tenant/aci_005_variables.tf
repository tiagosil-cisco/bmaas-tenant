locals {
  ico_input = jsondecode(file("${path.root}/input_vars.json")) // file that is sent by ICO

  aci_l3domain              = "OTT-CORE-MAIN-VPC-L3OUT"
  aci_vlan_pool_l3out       = "OTT-CORE-MAIN-VPC"
  aci_vlan_pool_phys_domain = "BRATTICE-FI-UCSX"

  vpc_interface_policy_group = "VPC_to_OTT-CORE"
  bgp_local_as               = "65003"
  bgp_remote_as              = "65001"
  vmm_name                   = "BMaaS-Infra"

}


variable "credentials" {}
variable "project_name" {}


variable "l3out_config" {
  default = {
    leaf_a           = "103"
    leaf_a_router_id = "10.255.255.103"
    leaf_b           = "104"
    leaf_b_router_id = "10.255.255.104"
  }
}

variable "physical_config" {
  default = {
    name   = "BRATTICE-FI-PHYSICAL"
    leaf_a = "103"
    leaf_b = "104"

    vpc_to_fi_a = "VPC_to_BRATTICE-FI-A"
    vpc_to_fi_b = "VPC_to_BRATTICE-FI-B"

  }
}