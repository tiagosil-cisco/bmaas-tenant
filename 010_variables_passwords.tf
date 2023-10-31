variable "credentials" {
  type = map(any)
  default = {
    aci = {
      username = "dovetail"
      password = "C!sco123"
      url      = "https://10.0.255.100"
    }
    nxos = {
      username = "nexus"
      password = "Dov3tail!"
      core01   = "https://10.0.0.252"
      core02   = "https://10.0.0.253"

    }

  }
}
