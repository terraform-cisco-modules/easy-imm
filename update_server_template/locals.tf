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
