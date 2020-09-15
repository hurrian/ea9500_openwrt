#
# Copyright (C) 2020 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=brcmfmac-firmware-4366c0-pcie-panamera
PKG_VERSION:=10.10.69.69
PKG_RELEASE:=1

PKG_MAINTAINER:=Kenneth Kasilag <kenneth@kasilag.me>

include $(INCLUDE_DIR)/package.mk

define Package/brcmfmac-firmware-4366c0-pcie-panamera
  SECTION:=firmware
  CATEGORY:=Firmware
  TITLE:=$(1)
endef

define Package/brcmfmac-firmware-4366c0-pcie-panamera/description
  Broadcom 4366c0 FullMAC PCIe firmware for Linksys EA9500
endef

define Build/Compile

endef

define Package/brcmfmac-firmware-4366c0-pcie-panamera/install
	$(INSTALL_DIR) $(1)/lib/firmware/brcm
	$(INSTALL_DATA) \
		./files/brcmfmac4366c-pcie.bin \
		$(1)/lib/firmware/brcm/
endef

$(eval $(call BuildPackage,brcmfmac-firmware-4366c0-pcie-panamera))
