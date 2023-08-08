#______________________________________________
#
# Intersight Provider Settings
#______________________________________________

variable "intersight_api_key_id" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "intersight_fqdn" {
  default     = "intersight.com"
  description = "Intersight Fully Qualified Domain Name."
  type        = string
}

variable "intersight_secret_key" {
  default     = "blah.txt"
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}
