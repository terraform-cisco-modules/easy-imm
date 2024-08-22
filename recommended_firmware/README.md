[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)

# Recommend Firmware

In the `recommended_firmware` folder is a simple terraform setup that you can use to query Intersight for the latest recommended firmware for servers.  

## Updates

* 2024-07-23: Output Below ran on August 22, 2024.

Following is an example output:

```
recommended_firmware = {
  "FIAttached" = {
    "4.3(2.240053)" = tolist([
      "UCSC-C220-M5",
      "UCSC-C240-M5",
      "UCSC-C480-M5",
    ])
    "4.3(4.240152)" = tolist([
      "UCSC-C220-M6",
      "UCSC-C220-M7",
      "UCSC-C225-M6",
      "UCSC-C240-M6",
      "UCSC-C240-M7",
      "UCSC-C245-M6",
    ])
    "5.2(2.240051)" = tolist([
      "UCSB-B200-M5",
      "UCSB-B200-M6",
      "UCSB-B480-M5",
    ])
    "5.2(2.240053)" = tolist([
      "UCSX-210C-M6",
      "UCSX-210C-M7",
      "UCSX-410C-M7",
    ])
  }
  "Standalone" = {
    "3.0(4r)" = tolist([
      "UCSC-C220-M4",
      "UCSC-C240-M4",
      "UCSC-C460-M4",
    ])
    "4.0(2r)" = tolist([
      "UCSC-C220-M4",
      "UCSC-C240-M4",
    ])
    "4.1(2m)" = tolist([
      "UCSC-C220-M4",
      "UCSC-C240-M4",
      "UCSC-C460-M4",
    ])
    "4.3(2.240053)" = tolist([
      "HX220C-M5",
      "HX240C-M5",
      "HXAF220C-M5",
      "HXAF240C-M5",
      "UCSC-C220-M5",
      "UCSC-C240-M5",
      "UCSC-C480-M5",
    ])
    "4.3(4.240152)" = tolist([
      "UCSC-C220-M6",
      "UCSC-C240-M6",
      "UCSC-C245-M6",
    ])
  }
}
```
