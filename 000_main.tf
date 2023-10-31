terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
    }
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

provider "aci" {
  username = var.credentials["aci"].username
  password = var.credentials["aci"].password
  url      = var.credentials["aci"].url
  insecure = true
}

provider "nxos" {

  username = var.credentials["nxos"].username
  password = var.credentials["nxos"].password
  devices  = local.nexus
}
