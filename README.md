<!-- BEGIN_TF_DOCS -->
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)

# Easy IMM
## Examples for Using the Easy IMM Terraform Modules

Examples are Shown in the Following Directories:

* `policies`
* `pools`
* `profiles`
* `templates`

### IMPORTANT NOTE

Notice the `ezi.yaml` extension on the files.  This is how the  `data.utils_yaml_merge.model` is configured to recognize the files that should be imported with the module.

## YAML Schema Notes for auto-completion, Help, and Error Validation:

If you would like to utilize Autocompletion, Help Context, and Error Validation, `(HIGHLY RECOMMENDED)` make sure the files all utilize the `.ezi.yaml` file extension.

### Modify `variables.auto.tfvars` to match environment

`variables.auto.tfvars` contains Terraform variables that I felt fit better outside of the YAML Data Model.  These variables should be configured to be unique to the deployment environment, but examples are shown for the Richfield environemnt in the module.

#### Notes for the `variables.auto.tfvars`:

* `intersight_fqdn`:  SaaS will by default be `intersight.com`.  Available in the event of CVA or PVA deployments.
* `moids_policies`:  Consume Policies from a Data Source instead of a Resource.  This is helpful if you separate the `policies` module from `profiles/templates`.
* `moids_pools`:  Consume Pools from a Data Source instead of a Resource.  This is helpful if you seperate the `pools` Module from the `policies` module.
* `tags`:  Not Required, but by default the version of the script is being flagged here.

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables

- Add variable `intersight_api_key_id` with the value of <your-api-key>
- Add variable `intersight_secret_key` with the value of <your-secret-file-content>

#### Add Other Variables as discussed below based on use cases

## [Cloud Posse `tfenv`](https://github.com/cloudposse/tfenv)

Command line utility to transform environment variables for use with Terraform. (e.g. HOSTNAME → TF_VAR_hostname)

Recently I adopted the `tfenv` runner to standardize environment variables with multiple orchestration tools.  tfenv makes it so you don't need to add TF_VAR_ to the variables when you add them to the environment.  But it doesn't work for windows would be the caveat.

In the export examples below, for the Linux Example, the 'TF_VAR_' is excluded because Cloud Posse tfenv is used to insert it during the run.

### Aliases for `.bashrc`

Additionally to Save time on typing commands I use the following aliases by editing the `.bashrc` for my environment.

```bash
alias tfa='tfenv terraform apply main.plan'
alias tfap='tfenv terraform apply -parallelism=1 main.plan'
alias tfd='terraform destroy'
alias tff='terraform fmt'
alias tfi='terraform init'
alias tfp='tfenv terraform plan -out=main.plan'
alias tfu='terraform init -upgrade'
alias tfv='terraform validate'
```

## IMPORTANT:

ALL EXAMPLES BELOW ASSUME USING `tfenv` in LINUX

#### Linux

```bash
export intersight_api_key_id="<your-api-key>"
export intersight_secret_key="<secret-key-file-location>"
```

#### Windows

```powershell
$env:TF_VAR_intersight_api_key_id="<your-api-key>"
$env:TF_VAR_intersight_secret_key="<secret-key-file-location>"
```

## Sensitive Variables for the Policies Module:

### Certificate Management - FIAttached Servers

* `cert_mgmt_certificate`: Options are 1-5 for Up to 5 Certificates.  Variable Should Point to the File Location of the PEM Certificate.
* `cert_mgmt_private_key`: Options are 1-5 for Up to 5 Private Keys.  Variable Should Point to the File Location of the PEM Private Key.

#### Linux

```bash
export cert_mgmt_certificate_1='<cert_mgmt_certificate_file_location>'
```
```bash
export cert_mgmt_private_key_1='<cert_mgmt_private_key_file_location>'
```

#### Windows

```powershell
$env:TF_VAR_cert_mgmt_certificate_1='<cert_mgmt_certificate_file_location>'
```
```powershell
$env:TF_VAR_cert_mgmt_private_key_1='<cert_mgmt_private_key_file_location>'
```

### Drive Security - KMIP Sensitive Variables

* `drive_security_password`: If Authentication is supported/used by the KMIP Server, This is the User Password to Configure.
* `drive_security_server_ca_certificate`: KMIP Server CA Certificate Contents.

#### Linux

```bash
export drive_security_password='<drive_security_password>'
```
```bash
export drive_security_server_ca_certificate='<drive_security_server_ca_certificate_file_location>'
```

#### Windows

```powershell
$env:TF_VAR_drive_security_password='<drive_security_password>'
```
```powershell
$env:TF_VAR_drive_security_server_ca_certificate='<drive_security_server_ca_certificate_file_location>'
```

### Firmware - CCO  Credentials

* `cco_user`: If Configuring Firmware Policies, the CCO User for Firmware Downloads.
* `cco_password`: If Configuring Firmware Policies, the CCO Password for Firmware Downloads.

#### Linux

```bash
export cco_user='<cco_user>'
```
```bash
export cco_password='<cco_password>'
```

#### Windows

```powershell
$env:TF_VAR_cco_user='<cco_user>'
```
```powershell
$env:TF_VAR_cco_password='<cco_password>'
```

### IPMI/iSCSI/LDAP/Local Users/SNMP/Virtual Media

* `ipmi_key_1`: Currently IPMI isn't Working, I would Skip this for Now.
* `iscsi_boot_password`: If Configuring CHAP or MSCHAP Authentication, this is the User Password to Use.
* `binding_parameters_password`: Although You can use a binding password, highly recommend using login user credentials instead in the module.
* `local_user_password`_1-5: If Configuring Multiple Users, increment the Password based on number of configured Users.
* `access_community_string`_1-5: Used to Configure 1 or More Community Strings.  Only used if assigned.
* `snmp_auth_password`_1-5: If Configuring 1 or More SNMP Users.  Only used if assigned.
* `snmp_privacy_password`_1-5: If Configuring SNMP Users and security_level set to `AuthPriv`.  Only used if assigned.
* `snmp_trap_community`_1-5: Used by SNMP Trap Servers if using v2c instead of v3.
* `vmedia_password`_1-5: If Configuring vMedia Mappings and method uses authentication.

#### Linux

```bash
export cco_user='<cco_user>'
```
```bash
export cco_password='<cco_password>'
```

#### Windows

```powershell
$env:TF_VAR_cco_user='<cco_user>'
```
```powershell
$env:TF_VAR_cco_password='<cco_password>'
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.36 |
| <a name="requirement_utils"></a> [utils](#requirement\_utils) | >= 0.1.3 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.36 |
| <a name="provider_utils"></a> [utils](#provider\_utils) | 0.2.5 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_pools"></a> [pools](#module\_pools) | terraform-cisco-modules/pools/intersight | 2.1.5 |
| <a name="module_policies"></a> [policies](#module\_policies) | terraform-cisco-modules/policies/intersight | 2.1.5 |
| <a name="module_domain_profiles"></a> [domain\_profiles](#module\_domain\_profiles) | terraform-cisco-modules/profiles-domain/intersight | 2.1.6 |
| <a name="module_profiles"></a> [profiles](#module\_profiles) | terraform-cisco-modules/profiles/intersight | 2.1.5 |

## NOTE:
**When the Data is merged from the YAML files, it will run through the modules using for_each loop(s).  Sensitive Variables cannot be added to a for_each loop, instead use the variables below to add sensitive values for policies.**

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_profiles"></a> [deploy\_profiles](#input\_deploy\_profiles) | Flag to Determine if Profiles Should be deployed. | `string` | `false` | no |
| <a name="input_intersight_api_key_id"></a> [intersight\_api\_key\_id](#input\_intersight\_api\_key\_id) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_intersight_fqdn"></a> [intersight\_fqdn](#input\_intersight\_fqdn) | Intersight Fully Qualified Domain Name. | `string` | `"intersight.com"` | no |
| <a name="input_intersight_secret_key"></a> [intersight\_secret\_key](#input\_intersight\_secret\_key) | Intersight Secret Key. | `string` | `"blah.txt"` | no |
| <a name="input_moids_policies"></a> [moids\_policies](#input\_moids\_policies) | Flag to Determine if Policies Should be associated using resource or data object. | `bool` | `false` | no |
| <a name="input_moids_pools"></a> [moids\_pools](#input\_moids\_pools) | Flag to Determine if Pools Should be associated using data object or from var.pools. | `bool` | `false` | no |
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | Type of Operating System.<br>* Linux<br>* Windows | `string` | `"Linux"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Key/Value Pairs to Assign as Attributes to the Policy. | `list(map(string))` | `[]` | no |
| <a name="input_cert_mgmt_certificate_1"></a> [cert\_mgmt\_certificate\_1](#input\_cert\_mgmt\_certificate\_1) | The Server Certificate, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_cert_mgmt_certificate_2"></a> [cert\_mgmt\_certificate\_2](#input\_cert\_mgmt\_certificate\_2) | The Server Certificate, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_cert_mgmt_certificate_3"></a> [cert\_mgmt\_certificate\_3](#input\_cert\_mgmt\_certificate\_3) | The Server Certificate, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_cert_mgmt_certificate_4"></a> [cert\_mgmt\_certificate\_4](#input\_cert\_mgmt\_certificate\_4) | The Server Certificate, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_cert_mgmt_certificate_5"></a> [cert\_mgmt\_certificate\_5](#input\_cert\_mgmt\_certificate\_5) | The Server Certificate, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_cert_mgmt_private_key_1"></a> [cert\_mgmt\_private\_key\_1](#input\_cert\_mgmt\_private\_key\_1) | The Server Private Key, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_cert_mgmt_private_key_2"></a> [cert\_mgmt\_private\_key\_2](#input\_cert\_mgmt\_private\_key\_2) | The Server Private Key, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_cert_mgmt_private_key_3"></a> [cert\_mgmt\_private\_key\_3](#input\_cert\_mgmt\_private\_key\_3) | The Server Private Key, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_cert_mgmt_private_key_4"></a> [cert\_mgmt\_private\_key\_4](#input\_cert\_mgmt\_private\_key\_4) | The Server Private Key, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_cert_mgmt_private_key_5"></a> [cert\_mgmt\_private\_key\_5](#input\_cert\_mgmt\_private\_key\_5) | The Server Private Key, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_drive_security_password"></a> [drive\_security\_password](#input\_drive\_security\_password) | Drive Security User Password. | `string` | `""` | no |
| <a name="input_drive_security_server_ca_certificate"></a> [drive\_security\_server\_ca\_certificate](#input\_drive\_security\_server\_ca\_certificate) | Drive Security Server CA Certificate, in PEM Format, File Location. | `string` | `"blah.txt"` | no |
| <a name="input_cco_password"></a> [cco\_password](#input\_cco\_password) | CCO User Account Password. | `string` | `""` | no |
| <a name="input_cco_user"></a> [cco\_user](#input\_cco\_user) | CCO User Account Email for Firmware Policies. | `string` | `"cco_user"` | no |
| <a name="input_ipmi_key"></a> [ipmi\_key](#input\_ipmi\_key) | Encryption key 1 to use for IPMI communication. It should have an even number of hexadecimal characters and not exceed 40 characters. | `string` | `""` | no |
| <a name="input_iscsi_boot_password"></a> [iscsi\_boot\_password](#input\_iscsi\_boot\_password) | Password to Assign to the iSCSI Boot Policy if doing Authentication. | `string` | `""` | no |
| <a name="input_binding_parameters_password"></a> [binding\_parameters\_password](#input\_binding\_parameters\_password) | The password of the user for initial bind process with an LDAP Policy. It can be any string that adheres to the following constraints. It can have character except spaces, tabs, line breaks. It cannot be more than 254 characters. | `string` | `""` | no |
| <a name="input_local_user_password_1"></a> [local\_user\_password\_1](#input\_local\_user\_password\_1) | Password to assign to a Local User Policy -> user. | `string` | `""` | no |
| <a name="input_local_user_password_2"></a> [local\_user\_password\_2](#input\_local\_user\_password\_2) | Password to assign to a Local User Policy -> user. | `string` | `""` | no |
| <a name="input_local_user_password_3"></a> [local\_user\_password\_3](#input\_local\_user\_password\_3) | Password to assign to a Local User Policy -> user. | `string` | `""` | no |
| <a name="input_local_user_password_4"></a> [local\_user\_password\_4](#input\_local\_user\_password\_4) | Password to assign to a Local User Policy -> user. | `string` | `""` | no |
| <a name="input_local_user_password_5"></a> [local\_user\_password\_5](#input\_local\_user\_password\_5) | Password to assign to a Local User Policy -> user. | `string` | `""` | no |
| <a name="input_persistent_passphrase"></a> [persistent\_passphrase](#input\_persistent\_passphrase) | Secure passphrase to be applied on the Persistent Memory Modules on the server. The allowed characters are:<br>  - a-z, A-Z, 0-9 and special characters: \u0021, &, #, $, %, +, ^, @, \_, *, -. | `string` | `""` | no |
| <a name="input_access_community_string_1"></a> [access\_community\_string\_1](#input\_access\_community\_string\_1) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `string` | `""` | no |
| <a name="input_access_community_string_2"></a> [access\_community\_string\_2](#input\_access\_community\_string\_2) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `string` | `""` | no |
| <a name="input_access_community_string_3"></a> [access\_community\_string\_3](#input\_access\_community\_string\_3) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `string` | `""` | no |
| <a name="input_access_community_string_4"></a> [access\_community\_string\_4](#input\_access\_community\_string\_4) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `string` | `""` | no |
| <a name="input_access_community_string_5"></a> [access\_community\_string\_5](#input\_access\_community\_string\_5) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `string` | `""` | no |
| <a name="input_snmp_auth_password_1"></a> [snmp\_auth\_password\_1](#input\_snmp\_auth\_password\_1) | SNMPv3 User Authentication Password. | `string` | `""` | no |
| <a name="input_snmp_auth_password_2"></a> [snmp\_auth\_password\_2](#input\_snmp\_auth\_password\_2) | SNMPv3 User Authentication Password. | `string` | `""` | no |
| <a name="input_snmp_auth_password_3"></a> [snmp\_auth\_password\_3](#input\_snmp\_auth\_password\_3) | SNMPv3 User Authentication Password. | `string` | `""` | no |
| <a name="input_snmp_auth_password_4"></a> [snmp\_auth\_password\_4](#input\_snmp\_auth\_password\_4) | SNMPv3 User Authentication Password. | `string` | `""` | no |
| <a name="input_snmp_auth_password_5"></a> [snmp\_auth\_password\_5](#input\_snmp\_auth\_password\_5) | SNMPv3 User Authentication Password. | `string` | `""` | no |
| <a name="input_snmp_privacy_password_1"></a> [snmp\_privacy\_password\_1](#input\_snmp\_privacy\_password\_1) | SNMPv3 User Privacy Password. | `string` | `""` | no |
| <a name="input_snmp_privacy_password_2"></a> [snmp\_privacy\_password\_2](#input\_snmp\_privacy\_password\_2) | SNMPv3 User Privacy Password. | `string` | `""` | no |
| <a name="input_snmp_privacy_password_3"></a> [snmp\_privacy\_password\_3](#input\_snmp\_privacy\_password\_3) | SNMPv3 User Privacy Password. | `string` | `""` | no |
| <a name="input_snmp_privacy_password_4"></a> [snmp\_privacy\_password\_4](#input\_snmp\_privacy\_password\_4) | SNMPv3 User Privacy Password. | `string` | `""` | no |
| <a name="input_snmp_privacy_password_5"></a> [snmp\_privacy\_password\_5](#input\_snmp\_privacy\_password\_5) | SNMPv3 User Privacy Password. | `string` | `""` | no |
| <a name="input_snmp_trap_community_1"></a> [snmp\_trap\_community\_1](#input\_snmp\_trap\_community\_1) | Community for a Trap Destination. | `string` | `""` | no |
| <a name="input_snmp_trap_community_2"></a> [snmp\_trap\_community\_2](#input\_snmp\_trap\_community\_2) | Community for a Trap Destination. | `string` | `""` | no |
| <a name="input_snmp_trap_community_3"></a> [snmp\_trap\_community\_3](#input\_snmp\_trap\_community\_3) | Community for a Trap Destination. | `string` | `""` | no |
| <a name="input_snmp_trap_community_4"></a> [snmp\_trap\_community\_4](#input\_snmp\_trap\_community\_4) | Community for a Trap Destination. | `string` | `""` | no |
| <a name="input_snmp_trap_community_5"></a> [snmp\_trap\_community\_5](#input\_snmp\_trap\_community\_5) | Community for a Trap Destination. | `string` | `""` | no |
| <a name="input_vmedia_password_1"></a> [vmedia\_password\_1](#input\_vmedia\_password\_1) | Password for a Virtual Media Policy -> mapping target. | `string` | `""` | no |
| <a name="input_vmedia_password_2"></a> [vmedia\_password\_2](#input\_vmedia\_password\_2) | Password for a Virtual Media Policy -> mapping target. | `string` | `""` | no |
| <a name="input_vmedia_password_3"></a> [vmedia\_password\_3](#input\_vmedia\_password\_3) | Password for a Virtual Media Policy -> mapping target. | `string` | `""` | no |
| <a name="input_vmedia_password_4"></a> [vmedia\_password\_4](#input\_vmedia\_password\_4) | Password for a Virtual Media Policy -> mapping target. | `string` | `""` | no |
| <a name="input_vmedia_password_5"></a> [vmedia\_password\_5](#input\_vmedia\_password\_5) | Password for a Virtual Media Policy -> mapping target. | `string` | `""` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_profiles"></a> [domain\_profiles](#output\_domain\_profiles) | Domain Profile Outputs: including cluster and switch Moids, policy assignments. |
| <a name="output_policies"></a> [policies](#output\_policies) | The Name of Each Policy Created with it's respective Moid. |
| <a name="output_pools"></a> [pools](#output\_pools) | The Name of Each Pool Created with it's respective Moid. |
| <a name="output_profiles"></a> [profiles](#output\_profiles) | The Name of Each Profile Created with it's respective Moid. |

# Sub Modules

If you want to see documentation on Variables for Submodules use the links below:

## Terraform Registry

### [*Policies*](https://registry.terraform.io/modules/terraform-cisco-modules/policies/intersight/latest)

### [*Pools*](https://registry.terraform.io/modules/terraform-cisco-modules/pools/intersight/latest)

### Profiles

### [*Domain*](https://registry.terraform.io/modules/terraform-cisco-modules/profiles-domain/intersight/latest)

### [*Chassis/Server + Templates*](https://registry.terraform.io/modules/terraform-cisco-modules/profiles/intersight/latest)
<!-- END_TF_DOCS -->