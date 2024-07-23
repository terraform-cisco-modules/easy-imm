[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)

# Recommend Firmware

In the `recommended_firmware` folder is a simple terraform setup that you can use to query Intersight for the latest recommended firmware for servers.  

## Updates

* 2024-07-23: Output Below ran on July 23, 2024.

Following is an example output:

```
recommended_firmware = {
  "FIAttached" = {
    "4.3(2.240009)" = tolist([
      "UCSC-C220-M5",
      "UCSC-C240-M5",
      "UCSC-C480-M5",
    ])
    "4.3(3.240043)" = tolist([
      "UCSC-C220-M6",
      "UCSC-C220-M7",
      "UCSC-C225-M6",
      "UCSC-C240-M6",
      "UCSC-C240-M7",
      "UCSC-C245-M6",
    ])
    "5.2(0.230127)" = tolist([
      "UCSB-B200-M5",
      "UCSB-B480-M5",
    ])
    "5.2(1.240010)" = tolist([
      "UCSB-B200-M6",
      "UCSX-210C-M6",
      "UCSX-210C-M7",
      "UCSX-410C-M7",
    ])
  }
}```
