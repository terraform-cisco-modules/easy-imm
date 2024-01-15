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
  #source = "/home/tyscott/terraform-cisco-modules/terraform-intersight-pools"
  source          = "terraform-cisco-modules/pools/intersight"
  version         = "4.0.2"
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
  #source = "/home/tyscott/terraform-cisco-modules/terraform-intersight-policies"
  source             = "terraform-cisco-modules/policies/intersight"
  version            = "4.0.2"
  for_each           = { for i in ["map"] : i => i if length([for e in sort(keys(local.model)) : lookup(local.model[e], "policies", {})]) > 0 }
  global_settings    = local.global_settings
  model              = { for k, v in local.model : k => v if length(regexall("^global_settings|intersight$", k)) == 0 }
  orgs               = local.orgs
  policies_sensitive = local.policies_sensitive
  pools              = module.pools
}

#_________________________________________________________________________________________
#
# Intersight:UCS Domain Profiles
# GUI Location: Infrastructure Service > Configure > Profiles : UCS Domain Profiles
#_________________________________________________________________________________________
module "domain_profiles" {
  #source = "/home/tyscott/terraform-cisco-modules/terraform-intersight-profiles-domain"
  source  = "terraform-cisco-modules/profiles-domain/intersight"
  version = "4.0.2"
  for_each = {
    for i in ["map"] : i => i if length([for e in sort(keys(local.model)) : lookup(lookup(local.model[e], "profiles", {}), "domain", {})]) > 0
  }
  global_settings = local.global_settings
  model           = { for k, v in local.model : k => v if length(regexall("^global_settings|intersight$", k)) == 0 }
  orgs            = local.orgs
  policies        = module.policies
}

#_________________________________________________________________________________________
#
# Intersight: UCS Domain Profiles
# GUI Location: Infrastructure Service > Configure > Profiles : UCS Domain Profiles
#_________________________________________________________________________________________
resource "intersight_fabric_switch_profile" "map" {
  depends_on = [module.policies]
  for_each   = local.switch_profiles
  action = length(regexall("^[A-Z]{3}[2-3][\\d]([0][1-9]|[1-4][0-9]|[5][0-3])[\\dA-Z]{4}$", each.value.serial_number)
  ) > 0 ? each.value.action : "No-op"
  lifecycle {
    ignore_changes = [
      action_params, ancestors, assigned_switch, create_time, description, domain_group_moid,
      mod_time, owners, parent, permission_resources, policy_bucket, running_workflows,
      shared_scope, src_template, tags, version_context
    ]
  }
  name = each.value.name
  switch_cluster_profile { moid = each.value.domain_moid }
  wait_for_completion = local.switch_profiles[element(keys(local.switch_profiles), length(keys(local.switch_profiles)) - 1)
  ].name == each.value.name ? true : false
}

#_________________________________________________________________________________________
#
# Sleep Timer between Deploying the Domain and Waiting for Server Discovery
#_________________________________________________________________________________________
#resource "time_sleep" "wait_for_server_discovery" {
#  depends_on      = [intersight_fabric_switch_profile.map]
#  for_each        = { for v in [0] : v => v if length(local.switch_profiles) > 0 }
#  create_duration = length([for v in keys(local.switch_profiles) : 1 if local.switch_profiles[v].action == "Deploy"]) > 0 ? "30m" : "1s"
#  triggers        = { always_run = length(local.wait_for_domain) > 0 ? timestamp() : 1 }
#}


#_________________________________________________________________________________________
#
# Intersight:UCS Chassis and Server Profiles
# GUI Location: Infrastructure Service > Configure > Profiles
#_________________________________________________________________________________________
module "profiles" {
  #source = "/home/tyscott/terraform-cisco-modules/terraform-intersight-profiles"
  source  = "terraform-cisco-modules/profiles/intersight"
  version = "4.0.2"
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
  #time_sleep      = time_sleep.wait_for_server_discovery
}

#_________________________________________________________________________________________
#
# Intersight: UCS Chassis Profiles
# GUI Location: Infrastructure Service > Configure > Profiles : UCS Chassis Profiles
#_________________________________________________________________________________________
resource "intersight_chassis_profile" "map" {
  depends_on = [module.profiles]
  for_each   = local.chassis
  action = length(regexall("^[A-Z]{3}[2-3][\\d]([0][1-9]|[1-4][0-9]|[5][0-3])[\\dA-Z]{4}$", each.value.serial_number)
  ) > 0 ? each.value.action : "No-op"
  lifecycle { ignore_changes = [
    action_params, ancestors, create_time, description, domain_group_moid, mod_time,
    owners, parent, permission_resources, policy_bucket, running_workflows, shared_scope,
    src_template, tags, version_context
  ] }
  name            = each.value.name
  target_platform = each.value.target_platform
  organization { moid = local.orgs[each.value.organization] }
}

#_________________________________________________________________________________________
#
# Intersight: UCS Server Profiles
# GUI Location: Infrastructure Service > Configure > Profiles : UCS Server Profiles
#_________________________________________________________________________________________
resource "intersight_server_profile" "map" {
  depends_on = [
    module.profiles
  ]
  for_each = { for k, v in local.server : k => v }
  action = length(regexall("^[A-Z]{3}[2-3][\\d]([0][1-9]|[1-4][0-9]|[5][0-3])[\\dA-Z]{4}$", each.value.serial_number)
  ) > 0 ? each.value.action : "No-op"
  target_platform = each.value.target_platform
  lifecycle { ignore_changes = [
    action_params, ancestors, assigned_server, associated_server, associated_server_pool,
    create_time, description, domain_group_moid, mod_time, owners, parent, permission_resources,
    policy_bucket, reservation_references, running_workflows, server_assignment_mode, server_pool,
    shared_scope, src_template, tags, target_platform, uuid, uuid_address_type, uuid_lease,
    uuid_pool, version_context
  ] }
  name = each.value.name
  uuid_address_type = length([for v in each.value.policy_bucket : v if length(regexall("pool", v.object_type)) > 0]
  ) > 0 ? "POOL" : length(compact([each.value.static_uuid_address])) > 0 ? "STATIC" : "NONE"
  organization { moid = local.orgs[each.value.organization] }
}
