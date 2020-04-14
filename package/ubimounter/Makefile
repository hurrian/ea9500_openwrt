#
# Copyright (C) 2009-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ubimounter
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_LICENSE:=GPLv2

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=utils
	CATEGORY:=Utilities
	DEPENDS:=+ubi-utils
	TITLE:=UBIFS Auto Mounter
	PKGARCH:=all
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/ubimounter
endef

define Package/$(PKG_NAME)/description
  Automatically mount UBIFS partitions on MTD flash.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./files/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./ubimounter.config $(1)/etc/config/ubimounter
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./ubimounter.init $(1)/etc/init.d/ubimounter
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
