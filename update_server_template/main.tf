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
