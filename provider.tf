#_______________________________________________________________________
#
# Terraform Required Parameters - Intersight Provider
# https://registry.terraform.io/providers/CiscoDevNet/intersight/latest
#_______________________________________________________________________

terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.48"
    }
    time = {
      source  = "time"
      version = "0.9.1"
    }
    utils = {
      source  = "netascode/utils"
      version = ">= 0.1.3"
    }
  }
  required_version = ">=1.3.0"
}

provider "intersight" {
  apikey    = var.intersight_api_key_id
  endpoint  = "https://${local.intersight_fqdn}"
  secretkey = fileexists(var.intersight_secret_key) ? file(var.intersight_secret_key) : var.intersight_secret_key
}
