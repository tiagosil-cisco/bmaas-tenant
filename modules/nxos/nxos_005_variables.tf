locals {
  ico_input     = jsondecode(file("${path.root}/input_vars.json")) // file that is sent by ICO
  bgp_local_as  = "65001"
  bgp_remote_as = "65003"
}