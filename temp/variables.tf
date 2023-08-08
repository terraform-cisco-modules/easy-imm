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

#__________________________________________________________________
#
# Certificate Management Sensitive Variables
#__________________________________________________________________

variable "cert_mgmt_certificate_1" {
  default     = "blah.txt"
  description = "The Server Certificate, in PEM Format, File Location."
  sensitive   = true
  type        = string
}

variable "cert_mgmt_certificate_2" {
  default     = "blah.txt"
  description = "The Server Certificate, in PEM Format, File Location."
  sensitive   = true
  type        = string
}

variable "cert_mgmt_certificate_3" {
  default     = "blah.txt"
  description = "The Server Certificate, in PEM Format, File Location."
  sensitive   = true
  type        = string
}

variable "cert_mgmt_certificate_4" {
  default     = "blah.txt"
  description = "The Server Certificate, in PEM Format, File Location."
  sensitive   = true
  type        = string
}

variable "cert_mgmt_certificate_5" {
  default     = "blah.txt"
  description = "The Server Certificate, in PEM Format, File Location."
  sensitive   = true
  type        = string
}

variable "cert_mgmt_private_key_1" {
  default     = "blah.txt"
  description = "The Server Private Key, in PEM Format, File Location."
  sensitive   = true
  type        = string
}

variable "cert_mgmt_private_key_2" {
  default     = "blah.txt"
  description = "The Server Private Key, in PEM Format, File Location."
  sensitive   = true
  type        = string
}

variable "cert_mgmt_private_key_3" {
  default     = "blah.txt"
  description = "The Server Private Key, in PEM Format, File Location."
  sensitive   = true
  type        = string
}

variable "cert_mgmt_private_key_4" {
  default     = "blah.txt"
  description = "The Server Private Key, in PEM Format, File Location."
  sensitive   = true
  type        = string
}

variable "cert_mgmt_private_key_5" {
  default     = "blah.txt"
  description = "The Server Private Key, in PEM Format, File Location."
  sensitive   = true
  type        = string
}


#__________________________________________________________________
#
# Drive Security Sensitive Variables
#__________________________________________________________________

variable "drive_security_password" {
  default     = ""
  description = "Drive Security User Password."
  sensitive   = true
  type        = string
}

variable "drive_security_server_ca_certificate" {
  default     = "blah.txt"
  description = "Drive Security Server CA Certificate, in PEM Format, File Location."
  sensitive   = true
  type        = string
}


#__________________________________________________________________
#
# Firmware Sensitive Variables
#__________________________________________________________________

variable "cco_password" {
  default     = ""
  description = "CCO User Account Password."
  sensitive   = true
  type        = string
}

variable "cco_user" {
  default     = "cco_user"
  description = "CCO User Account Email for Firmware Policies."
  sensitive   = true
  type        = string
}


#__________________________________________________________________
#
# IPMI Sensitive Variables
#__________________________________________________________________

variable "ipmi_key" {
  default     = ""
  description = "Encryption key 1 to use for IPMI communication. It should have an even number of hexadecimal characters and not exceed 40 characters."
  sensitive   = true
  type        = string
}

#__________________________________________________________________
#
# iSCSI Boot Sensitive Variable
#__________________________________________________________________

variable "iscsi_boot_password" {
  default     = ""
  description = "Password to Assign to the iSCSI Boot Policy if doing Authentication."
  sensitive   = true
  type        = string
}

#__________________________________________________________________
#
# LDAP Sensitive Variable
#__________________________________________________________________

variable "binding_parameters_password" {
  default     = ""
  description = "The password of the user for initial bind process with an LDAP Policy. It can be any string that adheres to the following constraints. It can have character except spaces, tabs, line breaks. It cannot be more than 254 characters."
  sensitive   = true
  type        = string
}

#__________________________________________________________________
#
# Local User Sensitive Variables
#__________________________________________________________________

variable "local_user_password_1" {
  default     = ""
  description = "Password to assign to a Local User Policy -> user."
  sensitive   = true
  type        = string
}

variable "local_user_password_2" {
  default     = ""
  description = "Password to assign to a Local User Policy -> user."
  sensitive   = true
  type        = string
}

variable "local_user_password_3" {
  default     = ""
  description = "Password to assign to a Local User Policy -> user."
  sensitive   = true
  type        = string
}

variable "local_user_password_4" {
  default     = ""
  description = "Password to assign to a Local User Policy -> user."
  sensitive   = true
  type        = string
}

variable "local_user_password_5" {
  default     = ""
  description = "Password to assign to a Local User Policy -> user."
  sensitive   = true
  type        = string
}

#__________________________________________________________________
#
# Persistent Memory Sensitive Variable
#__________________________________________________________________

variable "persistent_passphrase" {
  default     = ""
  description = <<-EOT
  Secure passphrase to be applied on the Persistent Memory Modules on the server. The allowed characters are:
    - a-z, A-Z, 0-9 and special characters: \u0021, &, #, $, %, +, ^, @, _, *, -.
  EOT
  sensitive   = true
  type        = string
}

#__________________________________________________________________
#
# SNMP Sensitive Variables
#__________________________________________________________________

variable "access_community_string_1" {
  default     = ""
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = string
}

variable "access_community_string_2" {
  default     = ""
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = string
}

variable "access_community_string_3" {
  default     = ""
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = string
}

variable "access_community_string_4" {
  default     = ""
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = string
}

variable "access_community_string_5" {
  default     = ""
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = string
}

variable "snmp_auth_password_1" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}

variable "snmp_auth_password_2" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}

variable "snmp_auth_password_3" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}

variable "snmp_auth_password_4" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}

variable "snmp_auth_password_5" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}

variable "snmp_privacy_password_1" {
  default     = ""
  description = "SNMPv3 User Privacy Password."
  sensitive   = true
  type        = string
}

variable "snmp_privacy_password_2" {
  default     = ""
  description = "SNMPv3 User Privacy Password."
  sensitive   = true
  type        = string
}

variable "snmp_privacy_password_3" {
  default     = ""
  description = "SNMPv3 User Privacy Password."
  sensitive   = true
  type        = string
}

variable "snmp_privacy_password_4" {
  default     = ""
  description = "SNMPv3 User Privacy Password."
  sensitive   = true
  type        = string
}

variable "snmp_privacy_password_5" {
  default     = ""
  description = "SNMPv3 User Privacy Password."
  sensitive   = true
  type        = string
}

variable "snmp_trap_community_1" {
  default     = ""
  description = "Community for a Trap Destination."
  sensitive   = true
  type        = string
}

variable "snmp_trap_community_2" {
  default     = ""
  description = "Community for a Trap Destination."
  sensitive   = true
  type        = string
}

variable "snmp_trap_community_3" {
  default     = ""
  description = "Community for a Trap Destination."
  sensitive   = true
  type        = string
}

variable "snmp_trap_community_4" {
  default     = ""
  description = "Community for a Trap Destination."
  sensitive   = true
  type        = string
}

variable "snmp_trap_community_5" {
  default     = ""
  description = "Community for a Trap Destination."
  sensitive   = true
  type        = string
}


#__________________________________________________________________
#
# Virtual Media Sensitive Variable
#__________________________________________________________________

variable "vmedia_password_1" {
  default     = ""
  description = "Password for a Virtual Media Policy -> mapping target."
  sensitive   = true
  type        = string
}

variable "vmedia_password_2" {
  default     = ""
  description = "Password for a Virtual Media Policy -> mapping target."
  sensitive   = true
  type        = string
}

variable "vmedia_password_3" {
  default     = ""
  description = "Password for a Virtual Media Policy -> mapping target."
  sensitive   = true
  type        = string
}

variable "vmedia_password_4" {
  default     = ""
  description = "Password for a Virtual Media Policy -> mapping target."
  sensitive   = true
  type        = string
}

variable "vmedia_password_5" {
  default     = ""
  description = "Password for a Virtual Media Policy -> mapping target."
  sensitive   = true
  type        = string
}
