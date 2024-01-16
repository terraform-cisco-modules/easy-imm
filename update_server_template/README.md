<!-- BEGIN_TF_DOCS -->
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)

# Update Server Template

## Updating Server Profile Templates attached to a Server Profiles

There are a few situations where Terraform doesn't work well with Intersight.  One example is with Templates associated to Server Profiles.  In the Intersight GUI when a change is made to a template or the template associated to a server profile is updated the `bulk/MoMerger` API is called to make the update to all the servers associated to a template.  This API call is ephimeral, meaning the object is not maintained.  So to provide a quick way to work around this I have the example in this folder that can be used to update the servers associated to a template when you make a change to the template or when you change the template associated to a servers.

Unfortanately, the other thing that would be nice to do along with this is to compare the template mod_time to timestamp(), but timestamp() doesn't take effect until apply so it fails on the plan.  For now this is the best workaround I could come up with.  If you have other thoughts feel free to submit a Pull request.

If you do use this, simply delete the terraform.tfstate file in this folder each time you run it.  The objects are ephimeral so the state file provides no benefit.
