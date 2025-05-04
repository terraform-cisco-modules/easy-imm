#______________________________________________
#
# Intersight Provider Settings
#______________________________________________

variable "intersight_api_key_id" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^[\\da-f]{24}/[\\da-f]{24}/[\\da-f]{24}$", var.intersight_api_key_id)) > 0
    error_message = "Interisght API Key Should match the following: ```^[\\da-f]{24}/[\\da-f]{24}/[\\da-f]{24}$```"
  }
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

variable "drive_security_current_security_key_passphrase" {
  default     = ""
  description = <<-EOT
    Drive Security Current Security Key Passphrase for Manual or Remote Key Management.  It must meet the following criteria:
      - One Uppercase Letter
      - One LowerCase Letter
      - One Number
      - One Special Character: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition = length(regexall("^$|[a-z]", var.drive_security_current_security_key_passphrase)
      ) > 0 && length(regexall("^$|[A-Z]", var.drive_security_current_security_key_passphrase)
      ) > 0 && length(regexall("^$|[\\d]", var.drive_security_current_security_key_passphrase)
      ) > 0 && length(regexall("^$|[=!&#$%+^@_*-]", var.drive_security_current_security_key_passphrase)
    ) > 0 && length(regexall("^$|^[a-zA-Z0-9=!&#$%+^@_*-]{8,32}$", var.drive_security_current_security_key_passphrase)) > 0
    error_message = "Should be at least 8 characters long and should include at least one uppercase letter, one lowercase letter, one number, and one of the following special characters: ```=!&#$%+^@_*-```."
  }
}


variable "drive_security_new_security_key_passphrase" {
  default     = ""
  description = <<-EOT
    Drive Security New Security Key Passphrase for Manual Key Management.  It must meet the following criteria:
      - One Uppercase Letter
      - One LowerCase Letter
      - One Number
      - One Special Character: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition = length(regexall("^$|[a-z]", var.drive_security_new_security_key_passphrase)
      ) > 0 && length(regexall("^$|[A-Z]", var.drive_security_new_security_key_passphrase)
      ) > 0 && length(regexall("^$|[\\d]", var.drive_security_new_security_key_passphrase)
      ) > 0 && length(regexall("^$|[=!&#$%+^@_*-]", var.drive_security_new_security_key_passphrase)
    ) > 0 && length(regexall("^$|^[a-zA-Z0-9=!&#$%+^@_*-]{8,32}$", var.drive_security_new_security_key_passphrase)) > 0
    error_message = "Should be at least 8 characters long and should include at least one uppercase letter, one lowercase letter, one number, and one of the following special characters: ```=!&#$%+^@_*-```."
  }
}

variable "drive_security_authentication_password" {
  default     = ""
  description = "Drive Security User Password."
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[!\"#%&\\'\\(\\)\\*\\+,\\-\\./:;<>@\\[\\\\\\]\\^_`\\{\\|\\}~a-zA-Z0-9]{6,80}$", var.drive_security_authentication_password)) > 0
    error_message = "Must match the following regular expression: ```^$|^[!\"#%&\\'\\(\\)\\*\\+,\\-\\./:;<>@\\[\\\\\\]\\^_`\\{\\|\\}~a-zA-Z0-9]{6,80}$```."
  }
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
  description = <<-EOT
    Cisco.com Authentication Password.  It must meet the following criteria:
      - One Uppercase Letter
      - One Lowercase Letter
      - One Number
      - One Special Character: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be between 12 and 60 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition = length(regexall("^$|[a-z]", var.cco_password)
      ) > 0 && length(regexall("^$|[A-Z]", var.cco_password)
      ) > 0 && length(regexall("^$|[\\d]", var.cco_password)
      ) > 0 && length(regexall("^$|[=!&#$%+^@_*-]", var.cco_password)
    ) > 0 && length(regexall("^$|^[a-zA-Z0-9=!&#$%+^@_*-]{12,60}$", var.cco_password)) > 0
    error_message = "Should be between 12 and 60 characters long and should include at least one uppercase letter, one lowercase letter, one number, and one of the following special characters: ```=!&#$%+^@_*-```."
  }
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

variable "ipmi_encryption_key" {
  default     = ""
  description = "Encryption key to use for IPMI communication. It should have an even number of hexadecimal characters and not exceed 40 characters."
  sensitive   = true
  type        = string
  validation {
    condition     = length(var.ipmi_encryption_key) % 2 == 0 && length(regexall("^$|^[a-fA-F\\d]{2,40}$", var.ipmi_encryption_key)) > 0
    error_message = "The encryption key to use for IPMI communication. It should have an even number of hexadecimal characters and not exceed 40 characters. Use “00” to disable encryption key use. This configuration is supported by all Standalone C-Series servers. FI-attached C-Series servers with firmware at minimum of 4.2.3a support this configuration. B/X-Series servers with firmware at minimum of 5.1.0.x support this configuration. IPMI commands using this key should append zeroes to the key to achieve a length of 40 characters."
  }
}

#__________________________________________________________________
#
# iSCSI Boot Sensitive Variable
#__________________________________________________________________

variable "iscsi_boot_password" {
  default     = ""
  description = <<-EOT
    Password to Assign to the iSCSI Boot Policy if doing Authentication. It can be any string that adheres to the following constraints.
      - Any non-white space character
      - Be between 12 and 16 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[\\S]{12,16}$", var.iscsi_boot_password)) > 0
    error_message = "Must match the following regular expression: ```^[\\S]{12,16}$```."
  }
}

#__________________________________________________________________
#
# LDAP Sensitive Variable
#__________________________________________________________________

variable "binding_parameters_password" {
  default     = ""
  description = <<-EOT
    The password of the user for initial bind process with an LDAP Policy. It can be any string that adheres to the following constraints.
      - Any non-white space character
      - Be between 8 and 254 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[\\S]{8,254}$", var.binding_parameters_password)) > 0
    error_message = "Must match the following regular expression: ```^[\\S]{8,254}$```."
  }
}

#__________________________________________________________________
#
# Local User Sensitive Variables
#__________________________________________________________________

variable "local_user_password_1" {
  default     = ""
  description = <<-EOT
    Password to assign to a Local User Policy -> User.
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be between 8 and 127 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z0-9!@#$%^&\\*+_=-]{8,127}$", var.local_user_password_1)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z0-9!@#$%^&\\*+_=-]{8,127}$```."
  }
}

variable "local_user_password_2" {
  default     = ""
  description = <<-EOT
    Password to assign to a Local User Policy -> User.
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be between 8 and 127 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z0-9!@#$%^&\\*+_=-]{8,127}$", var.local_user_password_2)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z0-9!@#$%^&\\*+_=-]{8,127}$```."
  }
}

variable "local_user_password_3" {
  default     = ""
  description = <<-EOT
    Password to assign to a Local User Policy -> User.
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be between 8 and 127 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z0-9!@#$%^&\\*+_=-]{8,127}$", var.local_user_password_3)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z0-9!@#$%^&\\*+_=-]{8,127}$```."
  }
}

variable "local_user_password_4" {
  default     = ""
  description = <<-EOT
    Password to assign to a Local User Policy -> User.
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be between 8 and 127 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z0-9!@#$%^&\\*+_=-]{8,127}$", var.local_user_password_4)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z0-9!@#$%^&\\*+_=-]{8,127}$```."
  }
}

variable "local_user_password_5" {
  default     = ""
  description = <<-EOT
    Password to assign to a Local User Policy -> User.
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be between 8 and 127 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z0-9!@#$%^&\\*+_=-]{8,127}$", var.local_user_password_5)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z0-9!@#$%^&\\*+_=-]{8,127}$```."
  }
}

#__________________________________________________________________
#
# MacSec Sensitive Variables
#__________________________________________________________________

variable "mac_sec_fallback_key_chain_secret_1" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Must start with the character 'J'
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 144 characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$", var.mac_sec_fallback_key_chain_secret_1)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Must start with the character 'J'
        - Be 144 characters in length
        - Match the following regular expression: ```^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$```.
    EOT
  }
}

variable "mac_sec_fallback_key_chain_secret_2" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Must start with the character 'J'
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 144 characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$", var.mac_sec_fallback_key_chain_secret_2)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Must start with the character 'J'
        - Be 144 characters in length
        - Match the following regular expression: ```^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$```.
    EOT
  }
}

variable "mac_sec_fallback_key_chain_secret_3" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Must start with the character 'J'
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 144 characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$", var.mac_sec_fallback_key_chain_secret_3)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Must start with the character 'J'
        - Be 144 characters in length
        - Match the following regular expression: ```^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$```.
    EOT
  }
}

variable "mac_sec_fallback_key_chain_secret_4" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Must start with the character 'J'
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 144 characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$", var.mac_sec_fallback_key_chain_secret_4)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Must start with the character 'J'
        - Be 144 characters in length
        - Match the following regular expression: ```^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$```.
    EOT
  }
}

variable "mac_sec_fallback_key_chain_secret_5" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Must start with the character 'J'
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 144 characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$", var.mac_sec_fallback_key_chain_secret_5)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Must start with the character 'J'
        - Be 144 characters in length
        - Match the following regular expression: ```^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$```.
    EOT
  }
}

variable "mac_sec_primary_key_chain_secret_1" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Must start with the character 'J'
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 144 characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$", var.mac_sec_primary_key_chain_secret_1)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Must start with the character 'J'
        - Be 144 characters in length
        - Match the following regular expression: ```^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$```.
    EOT
  }
}

variable "mac_sec_primary_key_chain_secret_2" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Must start with the character 'J'
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 144 characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$", var.mac_sec_primary_key_chain_secret_2)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Must start with the character 'J'
        - Be 144 characters in length
        - Match the following regular expression: ```^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$```.
    EOT
  }
}

variable "mac_sec_primary_key_chain_secret_3" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Must start with the character 'J'
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 144 characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$", var.mac_sec_primary_key_chain_secret_3)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Must start with the character 'J'
        - Be 144 characters in length
        - Match the following regular expression: ```^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$```.
    EOT
  }
}

variable "mac_sec_primary_key_chain_secret_4" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Must start with the character 'J'
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 144 characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$", var.mac_sec_primary_key_chain_secret_4)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Must start with the character 'J'
        - Be 144 characters in length
        - Match the following regular expression: ```^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$```.
    EOT
  }
}

variable "mac_sec_primary_key_chain_secret_5" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Must start with the character 'J'
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 144 characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$", var.mac_sec_primary_key_chain_secret_5)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Must start with the character 'J'
        - Be 144 characters in length
        - Match the following regular expression: ```^J[a-zA-Z0-9=!&#$%+^@_*-]{143,143}$```.
    EOT
  }
}


#__________________________________________________________________
#
# Persistent Memory Sensitive Variable
#__________________________________________________________________

variable "persistent_passphrase" {
  default     = ""
  description = <<-EOT
    Secure passphrase to be applied on the Persistent Memory Modules on the server. The allowed characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  #- Special Characters: `\u0021`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
  sensitive = true
  type      = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z0-9=!&#$%+^@_*-]{8,32}$", var.persistent_passphrase)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z0-9=!&#$%+^@_*-]{8,32}$```."
  }
}

#__________________________________________________________________
#
# SNMP Sensitive Variables
#__________________________________________________________________

variable "access_community_string_1" {
  default     = ""
  description = <<-EOT
    The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 32 characters long.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `_`, `*`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$", var.access_community_string_1)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$```."
  }
}

variable "access_community_string_2" {
  default     = ""
  description = <<-EOT
    The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 32 characters long.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `_`, `*`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$", var.access_community_string_2)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$```."
  }
}

variable "access_community_string_3" {
  default     = ""
  description = <<-EOT
    The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 32 characters long.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `_`, `*`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$", var.access_community_string_3)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$```."
  }
}

variable "access_community_string_4" {
  default     = ""
  description = <<-EOT
    The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 32 characters long.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `_`, `*`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$", var.access_community_string_4)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$```."
  }
}

variable "access_community_string_5" {
  default     = ""
  description = <<-EOT
    The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 32 characters long.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `_`, `*`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$", var.access_community_string_5)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$```."
  }
}

variable "snmp_auth_password_1" {
  default     = ""
  description = <<-EOT
    The SNMPv3 User Authorization password.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
      - Be between 8 and 64 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$", var.snmp_auth_password_1)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$```."
  }
}

variable "snmp_auth_password_2" {
  default     = ""
  description = <<-EOT
    The SNMPv3 User Authorization password.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
      - Be between 8 and 64 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$", var.snmp_auth_password_2)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$```."
  }
}

variable "snmp_auth_password_3" {
  default     = ""
  description = <<-EOT
    The SNMPv3 User Authorization password.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
      - Be between 8 and 64 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$", var.snmp_auth_password_3)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$```."
  }
}

variable "snmp_auth_password_4" {
  default     = ""
  description = <<-EOT
    The SNMPv3 User Authorization password.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
      - Be between 8 and 64 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$", var.snmp_auth_password_4)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$```."
  }
}

variable "snmp_auth_password_5" {
  default     = ""
  description = <<-EOT
    The SNMPv3 User Authorization password.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
      - Be between 8 and 64 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$", var.snmp_auth_password_5)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$```."
  }
}

variable "snmp_privacy_password_1" {
  default     = ""
  description = <<-EOT
    The SNMPv3 User Privacy password.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
      - Be between 8 and 64 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$", var.snmp_privacy_password_1)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$```."
  }
}

variable "snmp_privacy_password_2" {
  default     = ""
  description = <<-EOT
    The SNMPv3 User Privacy password.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
      - Be between 8 and 64 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$", var.snmp_privacy_password_2)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$```."
  }
}

variable "snmp_privacy_password_3" {
  default     = ""
  description = <<-EOT
    The SNMPv3 User Privacy password.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
      - Be between 8 and 64 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$", var.snmp_privacy_password_3)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$```."
  }
}

variable "snmp_privacy_password_4" {
  default     = ""
  description = <<-EOT
    The SNMPv3 User Privacy password.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
      - Be between 8 and 64 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$", var.snmp_privacy_password_4)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$```."
  }
}

variable "snmp_privacy_password_5" {
  default     = ""
  description = <<-EOT
    The SNMPv3 User Privacy password.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `@`, `_`, `*`, `-`
      - Be between 8 and 64 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$", var.snmp_privacy_password_5)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^@_*-]{8,64}$```."
  }
}

variable "snmp_trap_community_1" {
  default     = ""
  description = <<-EOT
    The SNMPv1, SNMPv2c community name to include on any trap messages sent to the SNMP host. The name can be 32 characters long.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `_`, `*`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$", var.snmp_trap_community_1)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$```."
  }
}

variable "snmp_trap_community_2" {
  default     = ""
  description = <<-EOT
    The SNMPv1, SNMPv2c community name to include on any trap messages sent to the SNMP host. The name can be 32 characters long.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `_`, `*`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$", var.snmp_trap_community_2)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$```."
  }
}

variable "snmp_trap_community_3" {
  default     = ""
  description = <<-EOT
    The SNMPv1, SNMPv2c community name to include on any trap messages sent to the SNMP host. The name can be 32 characters long.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `_`, `*`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$", var.snmp_trap_community_3)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$```."
  }
}

variable "snmp_trap_community_4" {
  default     = ""
  description = <<-EOT
    The SNMPv1, SNMPv2c community name to include on any trap messages sent to the SNMP host. The name can be 32 characters long.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `_`, `*`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$", var.snmp_trap_community_4)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$```."
  }
}

variable "snmp_trap_community_5" {
  default     = ""
  description = <<-EOT
    The SNMPv1, SNMPv2c community name to include on any trap messages sent to the SNMP host. The name can be 32 characters long.  Allowed Characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `.`, `=`, `!`, `&`, `#`, `$`, `%`, `+`, `^`, `_`, `*`, `-`
      - Be between 8 and 32 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$", var.snmp_trap_community_5)) > 0
    error_message = "Must match the following regular expression: ```^[a-zA-Z\\d\\.=!&#$%+^_*-]{8,32}$```."
  }
}


#__________________________________________________________________
#
# Switch Control Sensitive Variables
#__________________________________________________________________

variable "switch_control_aes_primary_key_1" {
  default     = ""
  description = <<-EOT
    The key octet string is a shared secret used in cryptographic operations.
    The valid size and format of the octet string depend on the selected KeyCryptographicAlgorithm and KeyEncryptionType.
    The allowed characters are:
      - Lower or Upper Case Letters
      - Numbers
      - Special Characters: `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `+`, `_`, `=`, `-`
      - Be 16 to 64 characters in length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[a-zA-Z0-9=!&#$%+^@_*-]{16,64}$", var.switch_control_aes_primary_key_1)) > 0
    error_message = <<-EOT
      Must meet the following criteria:
        - Be 16 to 64 characters in length.
        - Match the following regular expression: ```^[a-zA-Z0-9=!&#$%+^@_*-]{16,64}$```.
    EOT
  }
}


#__________________________________________________________________
#
# Virtual Media Sensitive Variable
#__________________________________________________________________

variable "vmedia_password_1" {
  default     = ""
  description = <<-EOT
    Virtual Media Policy -> Mapping Target Password when authentication is enabled.  Allowed Characters are:
      - Any non-white space character
      - Be between 6 and 255 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[\\S]{6,255}$", var.vmedia_password_1)) > 0
    error_message = "Must match the following regular expression: ```^[\\S]{6,255}$```."
  }
}

variable "vmedia_password_2" {
  default     = ""
  description = <<-EOT
    Virtual Media Policy -> Mapping Target Password when authentication is enabled.  Allowed Characters are:
      - Any non-white space character
      - Be between 6 and 255 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[\\S]{6,255}$", var.vmedia_password_2)) > 0
    error_message = "Must match the following regular expression: ```^[\\S]{6,255}$```."
  }
}

variable "vmedia_password_3" {
  default     = ""
  description = <<-EOT
    Virtual Media Policy -> Mapping Target Password when authentication is enabled.  Allowed Characters are:
      - Any non-white space character
      - Be between 6 and 255 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[\\S]{6,255}$", var.vmedia_password_3)) > 0
    error_message = "Must match the following regular expression: ```^[\\S]{6,255}$```."
  }
}

variable "vmedia_password_4" {
  default     = ""
  description = <<-EOT
    Virtual Media Policy -> Mapping Target Password when authentication is enabled.  Allowed Characters are:
      - Any non-white space character
      - Be between 6 and 255 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[\\S]{6,255}$", var.vmedia_password_4)) > 0
    error_message = "Must match the following regular expression: ```^[\\S]{6,255}$```."
  }
}

variable "vmedia_password_5" {
  default     = ""
  description = <<-EOT
    Virtual Media Policy -> Mapping Target Password when authentication is enabled.  Allowed Characters are:
      - Any non-white space character
      - Be between 6 and 255 Characters in Length.
  EOT
  sensitive   = true
  type        = string
  validation {
    condition     = length(regexall("^$|^[\\S]{6,255}$", var.vmedia_password_5)) > 0
    error_message = "Must match the following regular expression: ```^[\\S]{6,255}$```."
  }
}
