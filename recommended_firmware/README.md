[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)

# Recommend Firmware

In the `recommended_firmware` folder is a simple terraform setup that you can use to query Intersight for the latest recommended firmware for servers.  

Following is an example output:

```
Changes to Outputs:
+ recommended_firmware = {
    + FIAttached = {
        + "4.3(2.230270)" = [
            + "UCSC-C220-M5",
            + "UCSC-C220-M6",
            + "UCSC-C220-M7",
            + "UCSC-C225-M6",
            + "UCSC-C240-M5",
            + "UCSC-C240-M6",
            + "UCSC-C240-M7",
            + "UCSC-C245-M6",
            + "UCSC-C480-M5",
            ]
        + "5.2(0.230092)" = [
            + "UCSX-210C-M6",
            + "UCSX-210C-M7",
            + "UCSX-410C-M7",
            ]
        + "5.2(0.230100)" = [
            + "UCSB-B200-M5",
            + "UCSB-B200-M6",
            + "UCSB-B480-M5",
            ]
        }
    }
```
