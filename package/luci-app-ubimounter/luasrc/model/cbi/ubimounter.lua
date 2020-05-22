-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

local m, s

m = Map("ubimounter", translate("UBI Mounter"),	translatef("Mount a MTD partition as UBI"))

s = m:section(TypedSection, "ubimounter", translate("Settings"))
s.addremove = true
-- s.anonymous = true

s:option(Flag, "enable", translate("Enabled"), translate("Enables or disables this mount."))

mtd_by_name = s:option(Flag, "mtd_by_name", translate("Mount MTD by partition name"))
    mtd_by_name.default="false"

mtd_name = s:option(Value, "mtd_name", translate("MTD partition name"))
    mtd_name:depends("mtd_by_name","1")
    mtd_name.rmempty="false"

mtd_num = s:option(Value, "mtd_num", translate("MTD partition number"))
    mtd_num:depends("mtd_by_name","")
    mtd_num.maxlength="1"
    mtd_num.rmempty="true"

ubi_vol = s:option(Value, "ubi_vol", translate("UBI volume number"), translatef("UBI volume number you want to mount"))
    ubi_vol.default="0"
    ubi_vol.maxlength="1"

target = s:option(Value, "target", translate("Mount point"), translatef("Mounts this UBI to this directory under /mnt/"))
    target.optional="false"

return m
