#_______________________________________________________________________
#
# Terraform Required Parameters - Intersight Provider
# https://registry.terraform.io/providers/CiscoDevNet/intersight/latest
#_______________________________________________________________________

terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = "1.0.37"
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
  intersight_fqdn = lookup(local.model.global_settings, "intersight_fqdn", "intersight.com")
  model           = yamldecode(data.utils_yaml_merge.model.output)

  #__________________________________________________________________
  #
  # Profiles Information
  #__________________________________________________________________

  server = { for d in flatten([for org in sort(keys(local.model)) : [
    for v in lookup(lookup(local.model[org], "profiles", {}), "server", []) : [
      for e in lookup(v, "targets", []) : {
        name         = e.name
        organization = org
        ucs_server_template = length(regexall("/", lookup(v, "ucs_server_template", "UNUSED"))
        ) > 0 ? v.ucs_server_template : length(compact([lookup(v, "ucs_server_template", "")])) > 0 ? "${org}/${v.ucs_server_template}" : ""
      }
    ]
  ] if length(lookup(lookup(local.model[org], "profiles", {}), "server", [])) > 0]) : "${d.organization}/${d.name}" => d }
  template = { for i in distinct([for k, v in local.server : {
    name         = length(compact([v.ucs_server_template])) > 0 ? element(split("/", v.ucs_server_template), 1) : "UNUSED"
    organization = length(compact([v.ucs_server_template])) > 0 ? element(split("/", v.ucs_server_template), 0) : "UNUSED"
    } if length(compact([v.ucs_server_template])) > 0
  ]) : "${i.organization}/${i.name}" => i }
  templates = { for k, v in local.template : k => { servers = [for a, b in local.server : a if b.ucs_server_template == k] } }
  #} if length(regexall(tostring(element(split("T", timestamp()), 0)), tostring(element(split(" ", [for e in [for i in data.intersight_server_profile_template.map[k].results : i if i.organization[0].moid == local.orgs[v.organization]] : e][0])), 0))) > 0 }
}

#_________________________________________________________________________________________
#
# Data Model Merge Process - Merge YAML Files into HCL Format
#_________________________________________________________________________________________
data "terraform_remote_state" "map" {
  backend = "local"
  config  = { path = "../terraform.tfstate" }
}

data "utils_yaml_merge" "model" {
  input = concat([
    for file in fileset(path.module, "../*.ezi.yaml") : file(file)], [
    for file in fileset(path.module, "../p*/*.ezi.yaml") : file(file)], [
    for file in fileset(path.module, "../t*/*.ezi.yaml") : file(file)]
  )
  merge_list_items = false
}

resource "intersight_bulk_mo_merger" "name" {
  for_each     = local.templates
  merge_action = "Merge"
  lifecycle { ignore_changes = all }
  sources {
    object_type = "server.ProfileTemplate"
    moid        = data.terraform_remote_state.map.outputs.profiles.map.template[each.key].moid
  }
  dynamic "targets" {
    for_each = { for v in each.value.servers : v => v }
    content {
      object_type = "server.Profile"
      moid        = data.terraform_remote_state.map.outputs.profiles.map.server[targets.key].moid
    }
  }
}
output "server" {
  value = { for k, v in lookup(lookup(lookup(lookup(data.terraform_remote_state.map, "outputs", {}
  ), "profiles", {}), "map", {}), "server", {}) : k => v.moid }
}
output "template" {
  value = { for k, v in lookup(lookup(lookup(lookup(data.terraform_remote_state.map, "outputs", {}
  ), "profiles", {}), "map", {}), "template", {}) : k => v.moid }
}

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
