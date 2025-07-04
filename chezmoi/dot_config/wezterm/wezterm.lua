-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- This is where we actually apply the config
config = {

	-- >>> Advanced $TERM
	-- It is a variable that indicates the terminal type, used by the applications
	-- to take advantage of the capabilities of the terminal emulator
	--
	-- Before using this, follow the instructions to setup from here
	-- https://wezfurlong.org/wezterm/config/lua/config/term.html
	-- term = "wezterm",
	-- !!! BUG: Setting this will make ssh not working properly

	-- >>> Appearance
	color_scheme = "One Dark (Gogh)",
	colors = {
		foreground = "#a7aab0",
		background = "#232326",
	},
	font = wezterm.font("IosevkaTerm Nerd Font Mono", { weight = "Medium" }),
	font_size = 12,
	hide_tab_bar_if_only_one_tab = true,
	-- window_decorations = "RESIZE",
	window_background_opacity = 1.0, -- onedark theme bug on diagnostics bottom right color
	window_padding = {
		left = 15,
		right = 15,
		top = 15,
		bottom = 15,
	},
	wezterm.on("format-window-title", function()
		return "WezTerm"
	end),
	max_fps = 100, -- smoother experience, consume more power

	-- >>> Keybindings
	disable_default_key_bindings = true,
	keys = {
		-- Wezterm documentation recommend to enable this if disabling default
		{ key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
		{ key = "p", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },

		-- These are all default keybindings that I intuitively use
		{ key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		-- { key = "Insert", mods = "CTRL", action = act.CopyTo("PrimarySelection") },
		{ key = "Insert", mods = "CTRL", action = act.CopyTo("Clipboard") },
		{ key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
		-- { key = "Insert", mods = "SHIFT", action = act.PasteFrom("PrimarySelection") },
		{ key = "Insert", mods = "SHIFT", action = act.PasteFrom("Clipboard") },

		{ key = "+", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "_", mods = "CTRL", action = act.DecreaseFontSize },

		{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
		{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },

		-- I like this wezterm feature
		{ key = "Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
		{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
		{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },

        -- Misc
        { key = 'Backspace', mods = 'CTRL', action = act.SendKey {key = 'w', mods = 'CTRL'} },
	},
}

-- Return the configuration to wezterm
return config
