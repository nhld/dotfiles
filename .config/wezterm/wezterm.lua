local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.term = "wezterm"
config.front_end = "WebGpu"

config.colors = {}
config.colors.background = "#111111"
config.colors.tab_bar = {
	background = "#1f2329",
}

config.font_size = 12
config.font = wezterm.font("FiraMono Nerd Font")

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.inactive_pane_hsb = {
	saturation = 0.6,
	brightness = 0.6,
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.underline_position = -6
config.underline_thickness = "250%"

config.native_macos_fullscreen_mode = true

return config
