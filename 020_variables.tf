locals {
  ico_input    = jsondecode(file("input_vars.json")) // file that is sent by ICO
  project_name = local.ico_input.project_name.name

  nexus = [
    {
      name = "core01"
      url  = "https://10.0.0.252"
    },
    {
      name = "core02"
      url  = "https://10.0.0.253"
    }
  ]
}

variable "domain" {
  default = "bmaas-x.dovetail-lab.ca"
}