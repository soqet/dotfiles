local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- theme
config.color_scheme = "Catppuccin Mocha"

local defaultColors = wezterm.color.get_default_colors()

-- redefine 2 colors back to normal
config.colors = {
	indexed = {
		[16] = defaultColors.indexed[16],
		[17] = defaultColors.indexed[17],
	},
}
-- theme end

-- tab bar settings
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 50

config.enable_wayland = true

-- disable annoying keybindings
config.disable_default_key_bindings = true

MAIN_MOD = "ALT"

function getLastPathElem(path)
	return string.match(path, "[^%/]*$")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	local dir = pane.current_working_dir
	local process = pane.foreground_process_name
	if dir == nil then
		return string.format(" %d: %s ", tab.tab_index + 1, pane.title)
	end
	local filePath = dir.file_path
	local p = getLastPathElem(process) -- string.match(process, "[^%/]*$")
	local d = string.match(filePath, "([^%/]*)%/?$")
	if d == "" then
		d = filePath
	end
	local currentBuffer = tab.active_pane.user_vars.NVIM_CURRENT_BUFFER
	print(currentBuffer)
	if p == "nvim" and currentBuffer ~= nil then
		if currentBuffer:sub(0, #filePath - 1) == filePath:sub(0, #filePath - 1) then
			local suffix = currentBuffer:sub(#filePath)
			d = d .. suffix
		elseif currentBuffer ~= "" then
			d = ".../" .. getLastPathElem(currentBuffer)
		end
	end
	return {
		{ Text = string.format(" %d: %s %s ", tab.tab_index + 1, p, d) },
	}
end)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local process = pane.foreground_process_name
	local p = string.match(process, "[^%/]*$")
	local title = string.format("wezterm: %s", p)
	local currentBuffer = tab.active_pane.user_vars.NVIM_CURRENT_BUFFER
	if p == "nvim" and currentBuffer ~= nil then
		title = p .. ": " .. getLastPathElem(currentBuffer)
	end
	return title
end)

config.keys = {
	{
		key = "d",
		mods = MAIN_MOD,
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "q",
		mods = MAIN_MOD,
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "a",
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
	{
		key = "p",
		mods = MAIN_MOD,
		action = wezterm.action.ShowDebugOverlay,
	},
	{
		key = "j",
		mods = MAIN_MOD,
		action = act.ActivateTabRelative(1),
	},
	{
		key = "k",
		mods = MAIN_MOD,
		action = act.ActivateTabRelative(-1),
	},
	{ key = "v", mods = MAIN_MOD, action = act.PasteFrom("Clipboard") },
	{ key = "V", mods = MAIN_MOD, action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = MAIN_MOD, action = act.CopyTo("Clipboard") },
	{ key = "C", mods = MAIN_MOD, action = act.CopyTo("Clipboard") },
	-- default copy-paste binds
	{ key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
	{ key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
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
