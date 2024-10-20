local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  { family = 'JetBrainsMono Nerd Font' },
  { family = 'Symbols Nerd Font' },
}
config.use_cap_height_to_scale_fallback_fonts = true
config.font_size = 16
config.color_scheme = 'Catppuccin Macchiato'
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = '0.3cell',
  right = '0.3cell',
  top = '0.3cell',
  bottom = '0.3cell',
}
config.keys = {
  -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  { key = 'LeftArrow', mods = 'OPT', action = wezterm.action { SendString = '\x1bb' } },
  -- Make Option-Right equivalent to Alt-f; forward-word
  { key = 'RightArrow', mods = 'OPT', action = wezterm.action { SendString = '\x1bf' } },
}

-- and finally, return the configuration to wezterm
return config
