local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.active_pane.title
	if #title < max_width then
		title = title .. string.rep(" ", max_width - #title)
	elseif #title > max_width then
		title = title:sub(1, max_width - 4) .. " ..."
	end

	return title
end)

return {
	font = wezterm.font("PlemolJP Console NF"),
	default_prog = { "nu" },
	keys = {
		{ key = "l", mods = "ALT", action = "DisableDefaultAssignment" },
		{ key = "h", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "l", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
	},
	front_end = "WebGpu",
	tab_max_width = 20,
	window_decorations = "INTEGRATED_BUTTONS",
	check_for_updates = false,
}
