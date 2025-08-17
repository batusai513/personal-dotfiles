local wezterm = require 'wezterm'

local function move_pane(key, direction)
  return {
    key = key,
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection(direction),
  }
end

local function resize_pane(key, direction)
  return {
    key = key,
    action = wezterm.action.AdjustPaneSize { direction, 3 },
  }
end

-- This table will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  { family = 'JetBrainsMono Nerd Font' },
  { family = 'Symbols Nerd Font' },
}
-- rendering
-- config.front_end = 'WebGpu'
-- config.max_fps = 120
-- config.webgpu_power_preference = 'HighPerformance'

config.use_cap_height_to_scale_fallback_fonts = true
config.font_size = 14
config.color_scheme = 'Catppuccin Macchiato'
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = '0.3cell',
  right = '0.3cell',
  top = '0.3cell',
  bottom = '0.3cell',
}

config.set_environment_variables = {
  PATH = os.getenv 'PATH',
}

config.leader = {
  key = 'a',
  mods = 'CTRL',
  timeout_milliseconds = 1000,
}

config.keys = {
  {
    key = 'a',
    -- When we're in leader mode _and_ CTRL + A is pressed...
    mods = 'LEADER|CTRL',
    -- Actually send CTRL + A key to the terminal
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
  -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  { key = 'LeftArrow', mods = 'OPT', action = wezterm.action { SendString = '\x1bb' } },
  -- Make Option-Right equivalent to Alt-f; forward-word
  { key = 'RightArrow', mods = 'OPT', action = wezterm.action { SendString = '\x1bf' } },
  -- {
  --   key = ',',
  --   mods = 'SUPER',
  --   action = wezterm.action.SpawnCommandInNewTab {
  --     cwd = wezterm.home_dir,
  --     args = { 'e', wezterm.config_file },
  --   },
  -- },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },

  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_panes',
      one_shot = false,
      timeout_milliseconds = 350,
    },
  },

  move_pane('j', 'Down'),
  move_pane('k', 'Up'),
  move_pane('h', 'Left'),
  move_pane('l', 'Right'),
}

config.key_tables = {
  resize_panes = {
    resize_pane('h', 'Left'),
    resize_pane('j', 'Down'),
    resize_pane('k', 'Up'),
    resize_pane('l', 'Right'),
  },
}

config.enable_wayland = false
config.enable_kitty_keyboard = true

-- and finally, return the configuration to wezterm
return config
