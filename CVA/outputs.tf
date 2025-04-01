#__________________________________________________________
#
# Module Outputs
#__________________________________________________________
output "organizations" {
  description = "Outputs from the organizations module."
  value       = module.organizations
}

output "policies" {
  description = "Outputs from the policies module."
  value       = module.policies
}

output "pools" {
  description = "Outputs from the pools module."
  value       = module.pools
}

output "profiles" {
  description = "Outputs from the profiles module."
  value       = module.profiles
}
