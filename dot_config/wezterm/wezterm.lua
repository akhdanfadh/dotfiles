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

	-- >>> Non-Windows Startup
	-- default_cwd = "/home/dani",
	--
	-- Automatically attach to an existing tmux session
	-- default_prog = {
	-- 	"/usr/bin/zsh",
	-- 	"--login",
	-- 	"-c",
	-- 	[[
	-- 	if command -v tmux >/dev/null 2>&1; then
	-- 		tmux attach || tmux new;
	-- 	else
	-- 		exec zsh;
	-- 	fi
	-- 	]],
	-- },

	-- >>> Windows Startup
	default_domain = "WSL:ubuntu24_dev",

	-- >>> Appearance
	color_scheme = "One Dark (Gogh)",
	colors = {
		foreground = "#a7aab0",
		background = "#232326",
	},
	font = wezterm.font("ZedMono Nerd Font Mono", { weight = "Medium" }),
	font_size = 11,
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	window_background_opacity = 1.0, -- onedark theme bug on diagnostics bottom right color
	window_padding = {
		left = 20,
		right = 20,
		top = 20,
		bottom = 20,
	},

	-- >>> Keybindings
	disable_default_key_bindings = true,
	keys = {
		-- Wezterm documentation recommend to enable this if disabling default
		{ key = 'l', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
		{ key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },

		-- These are all default keybindings that I intuitively use
		{ key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
		{ key = 'Insert', mods = 'CTRL', action = act.CopyTo 'PrimarySelection' },
		{ key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
		{ key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },

		{ key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
		{ key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
		{ key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
		{ key = '_', mods = 'CTRL', action = act.DecreaseFontSize },

		{ key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
		{ key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
		{ key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },

		-- I like this wezterm feature
		{ key = 'Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
		{ key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
		{ key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
	},
}

-- Return the configuration to wezterm
return config
