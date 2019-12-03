ea9500_openwrt
=====
OpenWrt support for the Linksys EA9500

This repository aims to support the Linksys EA9500 `(linksys,panamera)` using the `swconfig` driver and configuration framework.

## Components
* [ea9500_support](https://github.com/hurrian/ea9500_openwrt/package/ea9500_support) : Adds LED, switch, and dual-partition support for the Linksys EA9500
* [brcmfmac-firmware-4366c0-pcie-ea9500](https://github.com/hurrian/ea9500_openwrt/package/firmware/brcmfmac-firmware-4366c0-pcie-ea9500) : Adds the proper Broadcom firmware version for Linksys EA9500 (10.10.69.69/FWID 01-8438621f)

## Building

### Step 1
To build OpenWrt for the EA9500, you must first add this feed to your `feeds.conf`

```
src-git ea9500_openwrt https://github.com/hurrian/ea9500_openwrt.git

$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```

### Step 2
You must then enable the Linksys EA9500 target in `target/linux/bcm53xx/image/Makefile` by uncommenting `TARGET_DEVICES += linksys-ea9500`.

```
define Device/linksys-ea9500
  DEVICE_VENDOR := Linksys
  DEVICE_MODEL := EA9500
  DEVICE_PACKAGES := $(BRCMFMAC_4366C0) $(USB3_PACKAGES)
  DEVICE_DTS := bcm47094-linksys-panamera
endef
TARGET_DEVICES += linksys-ea9500
```

### Step 3
In `make menuconfig`, select `Base System -> ea9500_support <*>`, and deselect `Firmware -> brcmfmac-firmware-4366c0 [ ]`.
For some reason, the latest Broadcom firmware from `linux-firmware` (10.10.122.x) is not properly supported by brcmfmac - using the newer version will render `radio2` non-functional.

## Quirks
The EA9500's CPU ports are directly connected to a BCM53012 switch wired to LAN4,7,8 plus an external BCM53125 switch wired to LAN1,2,3,5,6.
This may result in some pretty bizarre network operation.

## License
Files are licensed under the terms of GNU GPLv2 License; see LICENSE file for details.

## Credits
Credit goes to [Vivek Unune / npcomplete13](https://github.com/npcomplete13/openwrt) for figuring out the EA9500.
