
resource "nxos_bgp_peer" "core01_leaf_a" {
  device     = "core01"
  asn        = var.core_bgp_asn
  vrf        = "default"
  address    = cidrhost(local.ico_input.l3out_network.subnet, 1)
  remote_asn = var.aci_bgp_asn
}


resource "nxos_bgp_peer_address_family" "core01_leaf_a" {
  depends_on = [
    nxos_bgp_peer.core01_leaf_a
  ]
  device = "core01"

  asn            = var.core_bgp_asn
  vrf            = "default"
  address        = cidrhost(local.ico_input.l3out_network.subnet, 1)
  address_family = "ipv4-ucast"
}


resource "nxos_bgp_peer" "core01_leaf_b" {
  device     = "core01"
  asn        = var.core_bgp_asn
  vrf        = "default"
  address    = cidrhost(local.ico_input.l3out_network.subnet, 2)
  remote_asn = var.aci_bgp_asn
}


resource "nxos_bgp_peer_address_family" "core01_leaf_b" {
  depends_on = [
    nxos_bgp_peer.core01_leaf_a
  ]
  device = "core01"

  asn            = var.core_bgp_asn
  vrf            = "default"
  address        = cidrhost(local.ico_input.l3out_network.subnet, 2)
  address_family = "ipv4-ucast"
}



resource "nxos_bgp_peer" "core02_leaf_a" {
  device     = "core02"
  asn        = var.core_bgp_asn
  vrf        = "default"
  address    = cidrhost(local.ico_input.l3out_network.subnet, 1)
  remote_asn = var.aci_bgp_asn
}


resource "nxos_bgp_peer_address_family" "core02_leaf_a" {
  depends_on = [
    nxos_bgp_peer.core02_leaf_a
  ]
  device = "core02"

  asn            = var.core_bgp_asn
  vrf            = "default"
  address        = cidrhost(local.ico_input.l3out_network.subnet, 1)
  address_family = "ipv4-ucast"
}


resource "nxos_bgp_peer" "core02_leaf_b" {
  device     = "core02"
  asn        = var.core_bgp_asn
  vrf        = "default"
  address    = cidrhost(local.ico_input.l3out_network.subnet, 2)
  remote_asn = var.aci_bgp_asn
}


resource "nxos_bgp_peer_address_family" "core02_leaf_b" {
  depends_on = [
    nxos_bgp_peer.core02_leaf_a
  ]
  device = "core02"

  asn            = var.core_bgp_asn
  vrf            = "default"
  address        = cidrhost(local.ico_input.l3out_network.subnet, 2)
  address_family = "ipv4-ucast"
}