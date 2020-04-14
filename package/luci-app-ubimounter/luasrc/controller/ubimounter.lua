-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.ubimounter", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ubimounter") then
		return
	end

	local page

	page = entry({"admin", "system", "ubimounter"}, cbi("ubimounter"), _("UBI Mounter"))
	page.dependent = true
end
