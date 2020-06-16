ea9500_openwrt
=====
OpenWrt support for the Linksys EA9500 and EA9400

This repository aims to support the Linksys EA9500 and EA9400 `(linksys,panamera)` using the `swconfig` driver and configuration framework.

## Components
* [clear_partialboot](https://github.com/hurrian/ea9500_openwrt/package/clear_partialboot) : Ensures that Linksys dual-partition routers always boot to the correct partition
* `EA9500:` [brcmfmac-firmware-4366c0-pcie-panamera](https://github.com/hurrian/ea9500_openwrt/package/brcmfmac-firmware-4366c0-pcie-panamera) : Wireless firmware package that allows all three radios on EA9500 to function
* `EA9400:` [brcmfmac-firmware-4366b1-pcie-panamera](https://github.com/hurrian/ea9500_openwrt/package/brcmfmac-firmware-4366b1-pcie-panamera) : Wireless firmware package that allows all three radios on EA9400 to function
* `Optional:` [ubimounter](https://github.com/hurrian/ea9500_openwrt/package/ubimounter) : Scripts to automatically mount UBIFS partitions from a selected MTD device
* `Optional:` [luci-app-ubimounter](https://github.com/hurrian/ea9500_openwrt/package/luci-app-ubimounter) : LuCI configuration package for `ubimounter`

## Building

### Step 1
To build OpenWrt for the EA9500/EA9400, you must first add this feed to your `feeds.conf`

```
src-git ea9500_openwrt https://github.com/hurrian/ea9500_openwrt.git

$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```
### Step 2
The custom configuration overlay needs to be enabled by using the [custom files](https://openwrt.org/docs/guide-developer/build-system/use-buildsystem#custom_files) feature of the OpenWrt buildroot.
While in your buildroot directory (ex. ``~/openwrt``), run the following command:

```
~/openwrt $   ln -s feeds/ea9500_openwrt/files files
```

### Step 3A: For Linksys EA9500
You must then edit the Linksys EA9500 target in `target/linux/bcm53xx/image/Makefile` by uncommenting `TARGET_DEVICES += linksys-ea9500`, and setting `DEVICE_PACKAGES = $(IEEE8021X) kmod-brcmfmac brcmfmac-firmware-4366c0-pcie-panamera $(USB3_PACKAGES)`

```
define Device/linksys-ea9500
  DEVICE_VENDOR := Linksys
  DEVICE_MODEL := EA9500
  DEVICE_PACKAGES := $(IEEE8021X) kmod-brcmfmac brcmfmac-firmware-4366c0-pcie-panamera $(USB3_PACKAGES)
  DEVICE_DTS := bcm47094-linksys-panamera
endef
TARGET_DEVICES += linksys-ea9500
```

### Step 3B: For Linksys EA9400
You must add a target for Linksys EA9400 by adding the following into `target/linux/bcm53xx/image/Makefile`:

```
define Device/linksys-ea9400
  DEVICE_VENDOR := Linksys
  DEVICE_MODEL := EA9400
  DEVICE_PACKAGES := $(IEEE8021X) kmod-brcmfmac brcmfmac-firmware-4366b1-pcie-panamera $(USB3_PACKAGES)
  DEVICE_DTS := bcm47094-linksys-panamera
endef
TARGET_DEVICES += linksys-ea9400
```

### Step 4 (Optional)
Copy `999-vX.XX-0001-ARM-dts-BCM47094-LinksysPanamera-Specify-Flash-Partitions.patch` to `target/linux/bcm53xx/patches-4.14` to allow access to some extra space at the end of the router's flash.

```
~/openwrt $ cp feeds/ea9500_openwrt/999-vX.XX-0001-ARM-dts-BCM47094-LinksysPanamera-Specify-Flash-Partitions.patch target/linux/bcm53xx/patches-4.14/
```

### Step 5
In `make menuconfig`, you must select `Base System -> clear_partialboot <*>`.
You may then add any additional packages you want to use.

### Step 6
Issue the command to build OpenWrt.
```
~/openwrt $ make V=s
```
You will find the built images at `bin/targets/bcm53xx/generic`.

## Quirks
The CPU ports of the EA9500/EA9400 are directly connected to a BCM53012 switch wired to LAN4,7,8 plus an external BCM53125 switch wired to LAN1,2,3,5,6.
This means that you will only see the internal BCM53012 ports in LuCI's switch configuration.

On EA9500, Broadcom BCM4366C0 firmware versions past `10.10.69.69` are not properly supported by brcmfmac, resulting in dropouts in the 2.4GHz and secondary 5GHz radios.
The latest known working firmware for BCM4366C0 is supplied in the package `brcmfmac-firmware-4366c0-pcie-panamera`.

## License
Files are licensed under the terms of GNU GPLv2 License; see LICENSE file for details.

## Credits
Credit goes to [Vivek Unune / npcomplete13](https://github.com/npcomplete13/openwrt) for figuring out the `linksys,panamera` board (EA9500/EA9400).
Preliminary EA9200 support from [jithvk](https://github.com/jithvk/ea9x00_openwrt).
