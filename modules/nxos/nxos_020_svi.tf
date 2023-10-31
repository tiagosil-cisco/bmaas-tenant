/*
module "svi_core01" {
  source  = "netascode/interface-vlan/nxos"
  version = ">= 0.1.1"
  providers = {
    nxos = nxos.core01
  }

  id           = local.ico_input.l3out_network.vlan
  admin_state  = true
  vrf          = "default"
  ipv4_address = join("/", [cidrhost(local.ico_input.l3out_network.subnet, 5), split("/", local.ico_input.l3out_network.subnet)[1]])

}

module "svi_core02" {
  source  = "netascode/interface-vlan/nxos"
  version = ">= 0.1.1"
  providers = {
    nxos = nxos.core02
  }

  id           = local.ico_input.l3out_network.vlan
  admin_state  = true
  vrf          = "default"
  ipv4_address = join("/", [cidrhost(local.ico_input.l3out_network.subnet, 6), split("/", local.ico_input.l3out_network.subnet)[1]])

}


*/
resource "nxos_svi_interface" "core01-svi" {
  device       = "core01"
  interface_id = "vlan${local.ico_input.l3out_network.vlan}"
  admin_state  = "up"
}

resource "nxos_ipv4_interface" "core01-svi" {
  device       = "core01"
  depends_on   = [nxos_svi_interface.core01-svi]
  vrf          = "default"
  interface_id = nxos_svi_interface.core01-svi.interface_id

}

resource "nxos_ipv4_interface_address" "core01-svi" {
  depends_on   = [nxos_ipv4_interface.core01-svi]
  device       = "core01"
  vrf          = "default"
  interface_id = nxos_svi_interface.core01-svi.interface_id
  address      = join("/", [cidrhost(local.ico_input.l3out_network.subnet, 5), split("/", local.ico_input.l3out_network.subnet)[1]])

}



resource "nxos_svi_interface" "core02-svi" {
  device       = "core02"
  interface_id = "vlan${local.ico_input.l3out_network.vlan}"
  admin_state  = "up"
}

resource "nxos_ipv4_interface" "core02-svi" {
  depends_on   = [nxos_svi_interface.core02-svi]
  device       = "core02"
  vrf          = "default"
  interface_id = nxos_svi_interface.core01-svi.interface_id

}

resource "nxos_ipv4_interface_address" "core02-svi" {
  depends_on   = [nxos_ipv4_interface.core02-svi]
  device       = "core02"
  vrf          = "default"
  interface_id = nxos_svi_interface.core02-svi.interface_id
  address      = join("/", [cidrhost(local.ico_input.l3out_network.subnet, 6), split("/", local.ico_input.l3out_network.subnet)[1]])

}

