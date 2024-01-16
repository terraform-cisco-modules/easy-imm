#!/usr/bin/env python3
from dotmap import DotMap
import yaml
ydata = DotMap(yaml.safe_load(open("./profiles/server.ezi.yaml", "r")))
for key, value in ydata.items():
    for item in value.profiles.server:
        for i in item.targets:
            if not len(i.reservations) == 13:
                print(i.name)
                print(f'  identity len {len(i.reservations)}')
                for e in i.reservations: print(f'  - {e.identity_type}')
