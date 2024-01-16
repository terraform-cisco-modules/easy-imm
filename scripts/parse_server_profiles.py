#!/usr/bin/env python3
from dotmap import DotMap
import json, numpy, re, yaml

class MyDumper(yaml.Dumper):
    def increase_indent(self, flow=False, indentless=False):
        return super(MyDumper, self).increase_indent(flow, False)

data = DotMap(json.load(open("/mnt/c/Users/tyscott/Downloads/config-8082588f-9e50-45ab-b12e-23ae4fb02883.json", "r")))
templates = []
output = DotMap()
output['IND-UCS-701'] = DotMap(profiles = DotMap(server = []))
output['IND-UCS-702'] = DotMap(profiles = DotMap(server = []))
for e in data.config.orgs[2].ucs_server_profiles:
    if len(e.ucs_server_profile_template) > 0:
        templates.append(e.ucs_server_profile_template)
templates.sort()
templates = list(numpy.unique(numpy.array(templates)))
for template in templates:
    if 'IND-701' in str(template): org = 'IND-UCS-701'
    else: org = 'IND-UCS-702'
    output[org].profiles.server.append(dict(
        action = 'Deploy',
        attach_template = True,
        create_from_template = False,
        ignore_reservations = False,
        target_platform = 'FIAttached',
        targets = [],
        ucs_server_template = str(template)
    ))
empty = []
for e in data.config.orgs[2].ucs_server_profiles:
    indx = None
    if 'IND-701' in str(e.ucs_server_profile_template): org = 'IND-UCS-701'
    else: org = 'IND-UCS-702'
    indx = next((index for (index, d) in enumerate(output[org].profiles.server) if d['ucs_server_template'] == e.ucs_server_profile_template), None)
    if not indx == None:
        reservations = []
        for i in e.operational_state.identities:
            idict = {}
            for k, v in i.items():
                if re.search("vnic_name|vhba_name", k): idict.update({'interface':v})
                else: idict.update({k:v})
            reservations.append(idict)
        output[org].profiles.server[indx]['targets'].append(dict(
            name = e.name,
            serial_number = 'unknown',
            reservations = reservations
        ))
    else: empty.append(e.name)
#print(json.dumps(output, indent=4))
wr_file = open("servers.ezi.yaml", "w")
wr_file.write('---\n')
wr_file.write(yaml.dump(output.toDict(), Dumper=MyDumper, default_flow_style=False))
wr_file.close()
print(empty)