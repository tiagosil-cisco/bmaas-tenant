
resource "nxos_bridge_domain" "core01-vlan_l3out" {
  device       = "core01"
  fabric_encap = "vlan-${local.ico_input.l3out_network.vlan}"
}

resource "nxos_bridge_domain" "core02-vlan_l3out" {
  device       = "core02"
  fabric_encap = "vlan-${local.ico_input.l3out_network.vlan}"
}
