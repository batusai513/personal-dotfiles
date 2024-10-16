local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback {
  { family = 'JetBrainsMono Nerd Font' },
  { family = 'Symbols Nerd Font' },
}
config.use_cap_height_to_scale_fallback_fonts = true
config.font_size = 16
config.color_scheme = 'Catppuccin Macchiato'
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
-- config.window_decorations = "RESIZE"

-- and finally, return the configuration to wezterm
return config
