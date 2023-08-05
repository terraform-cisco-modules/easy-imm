#____________________________________________________________
#
# Moid Data Source
#____________________________________________________________

data "intersight_organization_organization" "orgs" {
}
#_________________________________________________________________________________________
#
# Data Model Merge Process - Merge YAML Files into HCL Format
#_________________________________________________________________________________________
data "utils_yaml_merge" "model" {
  input = concat([
    for file in fileset(path.module, "*.ezi.yaml") : file(file)], [
    for file in fileset(path.module, "*/*.ezi.yaml") : file(file)]
  )
  merge_list_items = false
}

locals {
  chassis = { for i in flatten([for key, value in module.profiles : [for k, v in value.chassis : v]
  ]) : "${i.organization}:${i.name}" => i }
  model = yamldecode(data.utils_yaml_merge.model.output)
  orgs  = { for k, v in data.intersight_organization_organization.orgs.results : v.name => v.moid }
  server = { for i in flatten([for key, value in module.profiles : [for k, v in value.server : v]
  ]) : "${i.organization}:${i.name}" => i }
  switch_profiles = { for i in flatten([for key, value in module.domain_profiles : [
    for k, v in value.switch_profiles : merge(v, { domain_moid = module.domain_profiles[key].domains[v.domain_profile] }
    )]
  ]) : "${i.organization}:${i.name}" => i }
  wait_for_domain = distinct(compact([for i in local.switch_profiles : i.action if i.action != "No-op"]))
  template = { for i in flatten([for key, value in module.profiles : [for k, v in value.template : v]
  ]) : "${i.organization}:${i.name}" => i }
  create_template = [for v in local.template : true if v.create_template == true]
}

#_________________________________________________________________________________________
#
# Intersight:Pools
# GUI Location: Infrastructure Service > Configure > Pools
#_________________________________________________________________________________________
module "pools" {
  #source = "../terraform-intersight-pools"
  source       = "terraform-cisco-modules/pools/intersight"
  version      = "2.1.5"
  for_each     = { for i in sort(keys(local.model)) : i => lookup(local.model[i], "pools", {}) if i != "intersight" }
  organization = each.key
  orgs         = local.orgs
  pools        = each.value
  tags         = var.tags
}

#_________________________________________________________________________________________
#
# Intersight:Policies
# GUI Location: Infrastructure Service > Configure > Policies
#_________________________________________________________________________________________
module "policies" {
  #source = "../terraform-intersight-policies"
  source         = "terraform-cisco-modules/policies/intersight"
  version        = "2.2.1"
  for_each       = { for i in sort(keys(local.model)) : i => lookup(local.model[i], "policies", {}) if i != "intersight" }
  moids_policies = var.moids_policies
  moids_pools    = var.moids_pools
  organization   = each.key
  orgs           = local.orgs
  policies       = each.value
  pools          = module.pools
  tags           = var.tags
  # Certificate Management Sensitive Variables
  cert_mgmt_certificate_1 = fileexists(var.cert_mgmt_certificate_1
  ) ? file(var.cert_mgmt_certificate_1) : var.cert_mgmt_certificate_1
  cert_mgmt_certificate_2 = fileexists(var.cert_mgmt_certificate_2
  ) ? file(var.cert_mgmt_certificate_2) : var.cert_mgmt_certificate_2
  cert_mgmt_certificate_3 = fileexists(var.cert_mgmt_certificate_3
  ) ? file(var.cert_mgmt_certificate_3) : var.cert_mgmt_certificate_3
  cert_mgmt_certificate_5 = fileexists(var.cert_mgmt_certificate_4
  ) ? file(var.cert_mgmt_certificate_4) : var.cert_mgmt_certificate_4
  cert_mgmt_certificate_4 = fileexists(var.cert_mgmt_certificate_5
  ) ? file(var.cert_mgmt_certificate_5) : var.cert_mgmt_certificate_5
  cert_mgmt_private_key_1 = fileexists(var.cert_mgmt_private_key_1
  ) ? file(var.cert_mgmt_private_key_1) : var.cert_mgmt_private_key_1
  cert_mgmt_private_key_2 = fileexists(var.cert_mgmt_private_key_2
  ) ? file(var.cert_mgmt_private_key_2) : var.cert_mgmt_private_key_2
  cert_mgmt_private_key_3 = fileexists(var.cert_mgmt_private_key_3
  ) ? file(var.cert_mgmt_private_key_3) : var.cert_mgmt_private_key_3
  cert_mgmt_private_key_4 = fileexists(var.cert_mgmt_private_key_4
  ) ? file(var.cert_mgmt_private_key_4) : var.cert_mgmt_private_key_4
  cert_mgmt_private_key_5 = fileexists(var.cert_mgmt_private_key_5
  ) ? file(var.cert_mgmt_private_key_5) : var.cert_mgmt_private_key_5
  # Drive Security Sensitive Variables
  drive_security_password = var.drive_security_password
  drive_security_server_ca_certificate = fileexists(var.drive_security_server_ca_certificate
  ) ? file(var.drive_security_server_ca_certificate) : var.drive_security_server_ca_certificate
  # Firmware Sensitive Variables
  cco_user     = var.cco_user
  cco_password = var.cco_password
  # IPMI Sensitive Variables
  ipmi_key_1 = var.ipmi_key
  # iSCSI Boot Sensitive Variable
  iscsi_boot_password = var.iscsi_boot_password
  # LDAP Sensitive Variable
  binding_parameters_password = var.binding_parameters_password
  # Local User Sensitive Variables
  local_user_password_1 = var.local_user_password_1
  local_user_password_2 = var.local_user_password_2
  local_user_password_3 = var.local_user_password_3
  local_user_password_4 = var.local_user_password_4
  local_user_password_5 = var.local_user_password_5
  # Persistent Memory Sensitive Variable
  persistent_passphrase = var.persistent_passphrase
  # SNMP Sensitive Variables
  access_community_string_1 = var.access_community_string_1
  access_community_string_2 = var.access_community_string_2
  access_community_string_3 = var.access_community_string_3
  access_community_string_4 = var.access_community_string_4
  access_community_string_5 = var.access_community_string_5
  snmp_auth_password_1      = var.snmp_auth_password_1
  snmp_auth_password_2      = var.snmp_auth_password_2
  snmp_auth_password_3      = var.snmp_auth_password_3
  snmp_auth_password_4      = var.snmp_auth_password_4
  snmp_auth_password_5      = var.snmp_auth_password_5
  snmp_privacy_password_1   = var.snmp_privacy_password_1
  snmp_privacy_password_2   = var.snmp_privacy_password_2
  snmp_privacy_password_3   = var.snmp_privacy_password_3
  snmp_privacy_password_4   = var.snmp_privacy_password_4
  snmp_privacy_password_5   = var.snmp_privacy_password_5
  snmp_trap_community_1     = var.snmp_trap_community_1
  snmp_trap_community_2     = var.snmp_trap_community_2
  snmp_trap_community_3     = var.snmp_trap_community_3
  snmp_trap_community_4     = var.snmp_trap_community_4
  snmp_trap_community_5     = var.snmp_trap_community_5
  # Virtual Media Sensitive Variable
  vmedia_password_1 = var.vmedia_password_1
  vmedia_password_2 = var.vmedia_password_2
  vmedia_password_3 = var.vmedia_password_3
  vmedia_password_4 = var.vmedia_password_4
  vmedia_password_5 = var.vmedia_password_5
}

#data "intersight_fabric_switch_profile" "check" {
#  
#  for_each = { for i in flatten([
#    for v in keys(local.model) : [
#      for e in lookup(lookup(local.model[v], "profiles", {}), "domain", []): e.name 
#    ]
#  ]): i => i }
#  name = each.value
#}


#_________________________________________________________________________________________
#
# Sleep Timer between Deploying the Domain and Waiting for Server Discovery
#_________________________________________________________________________________________
#resource "time_sleep" "wait_for_profile_validation" {
#  depends_on = [
#    module.policies
#  ]
#  create_duration = "2m"
#  triggers = {
#    always_run = "${timestamp()}"
#  }
#}

#_________________________________________________________________________________________
#
# Intersight:UCS Domain Profiles
# GUI Location: Infrastructure Service > Configure > Profiles : UCS Domain Profiles
#_________________________________________________________________________________________
module "domain_profiles" {
  #source = "../terraform-intersight-profiles-domain"
  source         = "terraform-cisco-modules/profiles-domain/intersight"
  version        = "2.1.6"
  for_each       = { for i in sort(keys(local.model)) : i => lookup(local.model[i], "profiles", {}) if i != "intersight" }
  moids_policies = var.moids_policies
  moids_pools    = var.moids_pools
  organization   = each.key
  orgs           = local.orgs
  profiles       = each.value
  tags           = var.tags
  policies       = module.policies
}

#_________________________________________________________________________________________
#
# Intersight: UCS Domain Profiles
# GUI Location: Infrastructure Service > Configure > Profiles : UCS Domain Profiles
#_________________________________________________________________________________________
resource "intersight_fabric_switch_profile" "switch_profiles" {
  depends_on = [
    module.policies
  ]
  for_each = local.switch_profiles
  action = length(regexall(
    "^[A-Z]{3}[2-3][\\d]([0][1-9]|[1-4][0-9]|[5][0-3])[\\dA-Z]{4}$", each.value.serial_number)
  ) > 0 ? each.value.action : "No-op"
  lifecycle {
    ignore_changes = [
      action_params,
      ancestors,
      assigned_switch,
      create_time,
      description,
      domain_group_moid,
      mod_time,
      owners,
      parent,
      permission_resources,
      policy_bucket,
      running_workflows,
      shared_scope,
      src_template,
      tags,
      version_context
    ]
  }
  name = each.value.name
  switch_cluster_profile {
    moid = each.value.domain_moid
  }
  wait_for_completion = local.switch_profiles[
    element(keys(local.switch_profiles), length(keys(local.switch_profiles)
  ) - 1)].name == each.value.name ? true : false
}

#_________________________________________________________________________________________
#
# Sleep Timer between Deploying the Domain and Waiting for Server Discovery
#_________________________________________________________________________________________
resource "time_sleep" "wait_for_server_discovery" {
  depends_on = [
    intersight_fabric_switch_profile.switch_profiles
  ]
  create_duration = length([
    for v in keys(local.switch_profiles) : 1 if local.switch_profiles[v
  ].action == "Deploy"]) > 0 ? "30m" : "1s"
  triggers = {
    always_run = length(local.wait_for_domain) > 0 ? "${timestamp()}" : 1
  }
}


#resource "time_sleep" "wait_for_profile_validation" {
#  depends_on = [
#    intersight_fabric_switch_profile.switch_profiles
#  ]
#  create_duration = "2m"
#  triggers = {
#    always_run = length(local.wait_for_domain) == 0 ? "${timestamp()}" : 1
#  }
#}

#_________________________________________________________________________________________
#
# Intersight:UCS Chassis and Server Profiles
# GUI Location: Infrastructure Service > Configure > Profiles
#_________________________________________________________________________________________
module "profiles" {
  #source = "../terraform-intersight-profiles"
  source         = "terraform-cisco-modules/profiles/intersight"
  version        = "2.2.1"
  for_each       = { for i in sort(keys(local.model)) : i => local.model[i] if i != "intersight" }
  moids_policies = var.moids_policies
  moids_pools    = var.moids_pools
  organization   = each.key
  orgs           = local.orgs
  policies       = module.policies
  pools          = module.pools
  profiles       = each.value
  model          = local.model
  tags           = var.tags
  time_sleep     = time_sleep.wait_for_server_discovery.id
}

#_________________________________________________________________________________________
#
# Intersight: UCS Chassis Profiles
# GUI Location: Infrastructure Service > Configure > Profiles : UCS Chassis Profiles
#_________________________________________________________________________________________
resource "intersight_chassis_profile" "chassis" {
  depends_on = [
    module.profiles
  ]
  for_each = local.chassis
  action = length(regexall(
    "^[A-Z]{3}[2-3][\\d]([0][1-9]|[1-4][0-9]|[5][0-3])[\\dA-Z]{4}$", each.value.serial_number)
  ) > 0 ? each.value.action : "No-op"
  lifecycle {
    ignore_changes = [
      action_params,
      ancestors,
      create_time,
      description,
      domain_group_moid,
      mod_time,
      owners,
      parent,
      permission_resources,
      policy_bucket,
      running_workflows,
      shared_scope,
      src_template,
      tags,
      version_context
    ]
  }
  name            = each.value.name
  target_platform = each.value.target_platform
  organization {
    moid = local.orgs[each.value.organization]
  }
}

#_________________________________________________________________________________________
#
# Intersight: UCS Server Profiles
# GUI Location: Infrastructure Service > Configure > Profiles : UCS Server Profiles
#_________________________________________________________________________________________
resource "intersight_server_profile" "server" {
  depends_on = [
    module.profiles
  ]
  for_each = { for k, v in local.server : k => v if v.create_from_template == false }
  action = length(regexall(
    "^[A-Z]{3}[2-3][\\d]([0][1-9]|[1-4][0-9]|[5][0-3])[\\dA-Z]{4}$", each.value.serial_number)
  ) > 0 ? each.value.action : "No-op"
  target_platform = each.value.target_platform
  lifecycle {
    ignore_changes = [
      action_params,
      ancestors,
      assigned_server,
      associated_server,
      associated_server_pool,
      create_time,
      description,
      domain_group_moid,
      mod_time,
      owners,
      parent,
      permission_resources,
      policy_bucket,
      reservation_references,
      running_workflows,
      server_assignment_mode,
      server_pool,
      shared_scope,
      src_template,
      tags,
      target_platform,
      uuid,
      uuid_address_type,
      uuid_lease,
      uuid_pool,
      version_context
    ]
  }
  name = each.value.name
  organization {
    moid = local.orgs[each.value.organization]
  }
}
