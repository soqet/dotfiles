local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.enable_wayland = true

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 50

-- config.leader = { key = "e", mods = "ALT", timeout_milliseconds = 1000 }
MAIN_MOD = "ALT"

config.keys = {
	{
		key = "c",
		mods = MAIN_MOD,
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "q",
		mods = MAIN_MOD,
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "d",
		mods = MAIN_MOD,
		action = act.ActivateLastTab,
	},
	{
		key = "m",
		mods = MAIN_MOD,
		action = wezterm.action_callback(function(_, pane)
			pane:move_to_new_window()
		end),
	},
}

local keysLen = #config.keys

for i = 1, 10 do
	config.keys[keysLen + i] = {
		key = tostring(math.fmod(i, 10)),
		mods = MAIN_MOD,
		action = act.ActivateTab(i - 1),
	}
end

return config
