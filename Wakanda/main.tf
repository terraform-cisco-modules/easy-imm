#_________________________________________________________________________________________
#
# Data Model Merge Process - Merge YAML Files into HCL Format
#_________________________________________________________________________________________
data "intersight_organization_organization" "orgs" {}
data "utils_yaml_merge" "model" {
  input = concat([
    for file in fileset(path.module, "*.ezi.yaml") : file(file)], [
    for file in fileset(path.module, "p*/*.ezi.yaml") : file(file)], [
    for file in fileset(path.module, "t*/*.ezi.yaml") : file(file)]
  )
  merge_list_items = false
}

#_________________________________________________________________________________________
#
# Intersight:Pools
# GUI Location: Infrastructure Service > Configure > Pools
#_________________________________________________________________________________________
module "pools" {
  # source = "/home/tyscott/terraform-cisco-modules/terraform-intersight-pools"
  source          = "terraform-cisco-modules/pools/intersight"
  version         = "4.2.11-14238"
  for_each        = { for i in ["map"] : i => i if length([for e in sort(keys(local.model)) : lookup(local.model[e], "pools", {})]) > 0 }
  global_settings = local.global_settings
  model           = { for k, v in local.model : k => v if length(regexall("^global_settings|intersight$", k)) == 0 }
  orgs            = local.orgs
}

#_________________________________________________________________________________________
#
# Intersight:Policies
# GUI Location: Infrastructure Service > Configure > Policies
#_________________________________________________________________________________________
module "policies" {
  # source = "/home/tyscott/terraform-cisco-modules/terraform-intersight-policies"
  source             = "terraform-cisco-modules/policies/intersight"
  version            = "4.2.11-14237"
  for_each           = { for i in ["map"] : i => i if length([for e in sort(keys(local.model)) : lookup(local.model[e], "policies", {})]) > 0 }
  global_settings    = local.global_settings
  model              = { for k, v in local.model : k => v if length(regexall("^global_settings|intersight$", k)) == 0 }
  orgs               = local.orgs
  policies_sensitive = local.policies_sensitive
  pools              = module.pools
}

#_________________________________________________________________________________________
#
# Intersight:UCS Chassis and Server Profiles
# GUI Location: Infrastructure Service > Configure > Profiles
#_________________________________________________________________________________________
module "profiles" {
  # source = "/home/tyscott/terraform-cisco-modules/terraform-intersight-profiles"
  source  = "terraform-cisco-modules/profiles/intersight"
  version = "4.2.11-14237"
  for_each = {
    for i in ["map"] : i => i if length([for e in sort(keys(local.model)) : lookup(lookup(local.model[e], "profiles", {}), "chassis", {})]
      ) > 0 || length([for e in sort(keys(local.model)) : lookup(lookup(lookup(local.model[e], "profiles", {}), "templates", {}), "server", {})]
    ) > 0 || length([for e in sort(keys(local.model)) : lookup(lookup(local.model[e], "profiles", {}), "server", {})]) > 0
  }
  global_settings = local.global_settings
  model           = { for k, v in local.model : k => v if length(regexall("^global_settings|intersight$", k)) == 0 }
  orgs            = local.orgs
  policies        = module.policies
  pools           = module.pools
}
