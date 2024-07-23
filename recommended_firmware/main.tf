#_______________________________________________________________________
#
# Terraform Required Parameters - Intersight Provider
# https://registry.terraform.io/providers/CiscoDevNet/intersight/latest
#_______________________________________________________________________

terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = "1.0.50"
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

locals {
  model           = yamldecode(data.utils_yaml_merge.model.output)
  intersight_fqdn = local.model.global_settings.intersight_fqdn
  recommended_firmware = {
    for i in ["FIAttached", "Standalone"] : i => {
      for fw in distinct(
        [for e in data.intersight_firmware_distributable.recommended[i].results : e.nr_version]
        ) : fw => distinct(sort(flatten([
          for r in data.intersight_firmware_distributable.recommended[i].results : [
            # for s in r.supported_models : s
            for s in r.supported_models : trimsuffix(trimsuffix(trimsuffix(
            trimsuffix(trimsuffix(trimsuffix(trimsuffix(trimsuffix(s, "L"), "D"), "X"), "N"), "S"), "M"), "SNEB"), "S2")
          ] if r.nr_version == fw
      ])))
    }
  }
}

#_________________________________________________________________________________________
#
# Data Model Merge Process - Merge YAML Files into HCL Format
#_________________________________________________________________________________________
data "utils_yaml_merge" "model" {
  input = concat([
    for file in fileset(path.module, "../*.ezi.yaml") : file(file)], [
    for file in fileset(path.module, "../*/*.ezi.yaml") : file(file)]
  )
  merge_list_items = false
}

data "intersight_firmware_distributable" "recommended" {
  for_each          = { for v in ["FIAttached", "Standalone"] : v => v }
  recommended_build = "Y"
  image_type        = each.value == "Standalone" ? "Standalone Server" : "Intersight Managed Mode Server"
}

output "recommended_firmware" {
  value = local.recommended_firmware
}

#______________________________________________
#
# Intersight Provider Settings
#______________________________________________

variable "intersight_api_key_id" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "intersight_secret_key" {
  default     = "blah.txt"
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}
