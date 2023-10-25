local wezterm = require("wezterm")
local act = wezterm.action

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--   local title = tab.active_pane.title
--   if #title < max_width then
--     title = title .. string.rep(" ", max_width - #title)
--   elseif #title > max_width then
--     title = title:sub(1, max_width - 4) .. " ..."
--   end
--
--   return title
-- end)

local function is_vim(pane)
	local process_name = string.gsub(pane:get_foreground_process_name(), "(.*[/\\])(.*)", "%2")
	wezterm.log_info(process_name)
	return process_name == "nvim" or process_name == "vim"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "SHIFT|META" or "CTRL|META",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL|SHIFT" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

return {
	font = wezterm.font("PlemolJP Console NF"),
	default_prog = { "nu" },
	keys = {
		{ key = "l", mods = "ALT", action = "DisableDefaultAssignment" },
		{ key = "h", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "l", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
		{
			key = "s",
			mods = "CTRL|ALT",
			action = act.SplitVertical({
				domain = "DefaultDomain",
			}),
		},
		{
			key = "v",
			mods = "CTRL|ALT",
			action = act.SplitHorizontal({
				domain = "DefaultDomain",
			}),
		},
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),
		-- resize panes
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),
	},
	front_end = "WebGpu",
	tab_max_width = 20,
	window_decorations = "INTEGRATED_BUTTONS",
	check_for_updates = false,
	enable_scroll_bar = true,
}
