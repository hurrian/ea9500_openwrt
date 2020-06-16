#
# Copyright (C) 2020 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=brcmfmac-firmware-4366b1-pcie-panamera
PKG_VERSION:=10.10.122.45
PKG_RELEASE:=1

PKG_MAINTAINER:=Kenneth Kasilag <kenneth@kasilag.me>

include $(INCLUDE_DIR)/package.mk

define Package/brcmfmac-firmware-4366b1-pcie-panamera
  SECTION:=firmware
  CATEGORY:=Firmware
  TITLE:=$(1)
endef

define Package/brcmfmac-firmware-4366c0-pcie-panamera/description
  Broadcom 4366b1 FullMAC PCIe firmware for Linksys EA9400
endef

define Build/Compile

endef

define Package/brcmfmac-firmware-4366b1-pcie-panamera/install
	$(INSTALL_DIR) $(1)/lib/firmware/brcm
	$(INSTALL_DATA) \
		./files/brcmfmac4366b-pcie.bin \
		$(1)/lib/firmware/brcm/
endef

$(eval $(call BuildPackage,brcmfmac-firmware-4366b1-pcie-panamera))
