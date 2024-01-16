#!/usr/bin/env python3
from dotmap import DotMap
import json, yaml

class MyDumper(yaml.Dumper):
    def increase_indent(self, flow=False, indentless=False):
        return super(MyDumper, self).increase_indent(flow, False)

data = DotMap(json.load(open("/mnt/c/Users/tyscott/Downloads/config-8082588f-9e50-45ab-b12e-23ae4fb02883.json", "r")))
templates = []
output = DotMap()
output['UCS-VDI'].policies.vlan = [DotMap(
    name = 'IND-VLANS',
    vlans = []
)]
for e in data.config.orgs[2].vlan_policies[0].vlans:
    edict = {'auto_allow_on_uplinks':True}
    for k, v in e.items():
        if k == 'auto_allow_on_uplinks': count = 0
        elif k == 'id': edict.update({'vlan_list': str(v)})
        else: edict.update({k:v})
    edict = dict(sorted(edict.items()))
    output['UCS-VDI'].policies.vlan[0].vlans.append(edict)
wr_file = open("vlan.ezi.yaml", "w")
wr_file.write('---\n')
wr_file.write(yaml.dump(output.toDict(), Dumper=MyDumper, default_flow_style=False))
wr_file.close()