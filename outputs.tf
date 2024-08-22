#__________________________________________________________
#
# Module Outputs
#__________________________________________________________
output "organizations" {
  description = "The Name of Each Organization/Resource Groups Created with it's respective Moid."
  value       = module.organizations
}

output "policies" {
  description = "The Name of Each Policy Created with it's respective Moid."
  value       = module.policies
}

output "pools" {
  description = "The Name of Each Pool Created with it's respective Moid."
  value       = module.pools
}

output "profiles" {
  description = "The Name of Each Profile Created with it's respective Moid."
  value       = module.profiles
}
