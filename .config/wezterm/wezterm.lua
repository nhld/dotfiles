local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.colors = {}
config.colors.background = '#111111'

config.scrollback_lines = 2000

config.font_size = 12
config.font = wezterm.font 'FiraMono Nerd Font'

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.colors.tab_bar = {
  background = '#1f2329',
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

--config.check_for_updates = false

return config
