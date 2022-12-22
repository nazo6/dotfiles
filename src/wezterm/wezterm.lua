local wezterm = require("wezterm")

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
	default_prog = { "powershell", "pwsh" },
	keys = {
		{ key = "l", mods = "ALT", action = "ShowLauncher" },
	},
	front_end = "WebGpu",
	tab_max_width = 20,
}
