#data "intersight_firmware_distributable" "recommended" {
#  recommended_build = "Y"
#  import_state      = "Imported"
#  image_type        = "Intersight Managed Mode Server"
#}

#locals {
#  firmware_list = distinct([ for e in data.intersight_firmware_distributable.recommended.results : e.nr_version ])
#  firmware = {
#    for e in local.firmware_list : e => distinct(sort(flatten([
#      for i in data.intersight_firmware_distributable.recommended.results : [
#        for s in i.supported_models : trimsuffix(trimsuffix(trimsuffix(trimsuffix(trimsuffix(trimsuffix(s, "L"
#        ), "D"), "X"), "N"), "S"), "M")] if i.nr_version == e
#    ])))
#  }
#}

output "firmware" {
  value = local.firmware
}