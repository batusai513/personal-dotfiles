local wezterm = require 'wezterm'
local gpus = wezterm.gui and wezterm.gui.enumerate_gpus() or {}

-- Catppuccin Macchiato palette
local colors = {
  bg       = '#24273a', -- base
  mantle   = '#1e2030',
  crust    = '#181926',
  surface0 = '#363a4f',
  overlay0 = '#6e738d',
  subtext1 = '#b8c0e0',
  text     = '#cad3f5',
  -- accent colors for pill tabs (cycle per tab index)
  accents  = {
    '#8aadf4', -- blue
    '#a6da95', -- green
    '#eed49f', -- yellow
    '#f5a97f', -- peach
    '#ed8796', -- red
    '#c6a0f6', -- mauve
    '#91d7e3', -- sky
    '#8bd5ca', -- teal
  },
}

-- Pill shape: rounded left/right caps
local PILL_LEFT  = utf8.char(0xe0b6) -- 
local PILL_RIGHT = utf8.char(0xe0b4) -- 

local function tab_title(tab)
  local title = tab.tab_title
  if title and #title > 0 then return title end
  local pane = tab.active_pane
  local proc = pane.foreground_process_name:match('([^/\\]+)$') or ''
  local cwd  = ''
  if pane.current_working_dir then
    cwd = pane.current_working_dir.file_path:match('([^/]+)$') or ''
  end
  return (tab.tab_index + 1) .. ':' .. proc .. ':' .. cwd
end

local function accent_for(tab)
  return colors.accents[(tab.tab_index % #colors.accents) + 1]
end

wezterm.on('format-tab-title', function(tab, _, _, cfg, hover, max_width)
  local title = wezterm.truncate_right(tab_title(tab), max_width - 4)

  if cfg.use_fancy_tab_bar then
    -- fancy mode: plain text, colors from config.colors.tab_bar
    return ' ' .. title .. ' '
  end

  -- retro/pill mode
  local accent = accent_for(tab)
  local bg, fg
  if tab.is_active then
    bg = accent
    fg = colors.crust   -- dark text on bright pill
  elseif hover then
    bg = colors.surface0
    fg = accent         -- accent text on hover
  else
    bg = colors.surface0
    fg = colors.overlay0
  end

  return {
    { Background = { Color = colors.crust } },
    { Foreground = { Color = bg           } },
    { Text       = PILL_LEFT              },
    { Background = { Color = bg           } },
    { Foreground = { Color = fg           } },
    { Text       = ' ' .. title .. ' '   },
    { Background = { Color = colors.crust } },
    { Foreground = { Color = bg           } },
    { Text       = PILL_RIGHT             },
  }
end)

local function resize_pane(key, direction)
  return {
    key = key,
    action = wezterm.action.AdjustPaneSize { direction, 3 },
  }
end

-- This table will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  { family = 'JetBrainsMono Nerd Font', weight = 'DemiBold', stretch = 'Normal' },
  { family = 'Symbols Nerd Font' },
}
-- rendering
config.front_end = 'WebGpu'
config.max_fps = 120
config.webgpu_power_preference = 'HighPerformance'
if gpus[1] then
  config.webgpu_preferred_adapter = gpus[1] -- explicitly select best available GPU
end

config.use_cap_height_to_scale_fallback_fonts = true
config.font_size = 14
config.harfbuzz_features = { 'calt=1' } -- keep programming ligatures, disable others
config.color_scheme = 'Catppuccin Macchiato'
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = '0.3cell',
  right = '0.3cell',
  top = '0.3cell',
  bottom = '0.3cell',
}
-- Toggle between fancy and retro/powerline: set to false to try powerline
-- Toggle between fancy and retro/powerline: set to false to try powerline
config.use_fancy_tab_bar = false

config.window_frame = {
  font             = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'DemiBold' },
  font_size        = 12.0,
  active_titlebar_bg   = '#1e2030', -- Catppuccin Macchiato: mantle
  inactive_titlebar_bg = '#181926', -- Catppuccin Macchiato: crust
}

config.colors = {
  tab_bar = {
    background = '#181926',       -- crust — pill floats on dark bar
    active_tab = {
      bg_color  = '#363a4f',      -- surface0
      fg_color  = '#cad3f5',      -- text
      intensity = 'Normal',
    },
    inactive_tab = {
      bg_color  = '#1e2030',      -- mantle
      fg_color  = '#6e738d',      -- overlay0
    },
    inactive_tab_hover = {
      bg_color  = '#363a4f',      -- surface0
      fg_color  = '#b8c0e0',      -- subtext1
      italic    = true,
    },
    new_tab = {
      bg_color  = '#1e2030',      -- mantle
      fg_color  = '#6e738d',      -- overlay0
    },
    new_tab_hover = {
      bg_color  = '#363a4f',      -- surface0
      fg_color  = '#cad3f5',      -- text
    },
  },
}
config.scrollback_lines = 10000

-- Dim inactive panes (cheaper than opacity)
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.85,
}

config.set_environment_variables = {
  PATH = os.getenv 'PATH',
}

-- Left Option → Alt sequences (consistent with kitty/ghostty macos_option_as_alt = left)
-- Right Option → Unicode (macOS default)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

-- Copy selected text to clipboard on mouse release
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'Clipboard',
  },
}

config.leader = {
  key = 'a',
  mods = 'CTRL',
  timeout_milliseconds = 1000,
}

config.keys = {
  -- Pass CTRL+A through when pressing LEADER+CTRL+A
  { key = 'a', mods = 'LEADER|CTRL', action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' } },

  -- Pane navigation: ctrl+shift+hjkl (vim-style, cross-platform)
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },

  -- Tab navigation: cross-platform + macOS aliases
  -- WezTerm sees the shifted character: SHIFT+[ = {, SHIFT+] = }
  { key = '{', mods = 'CTRL|SHIFT',  action = wezterm.action.ActivateTabRelative(-1) },
  { key = '}', mods = 'CTRL|SHIFT',  action = wezterm.action.ActivateTabRelative(1) },
  { key = '{', mods = 'SHIFT|SUPER', action = wezterm.action.ActivateTabRelative(-1) },
  { key = '}', mods = 'SHIFT|SUPER', action = wezterm.action.ActivateTabRelative(1) },

  -- Splits: ctrl+shift+\ (vertical) and ctrl+shift+- (horizontal) — cross-platform
  -- WezTerm sees the shifted character: SHIFT+\ = |, SHIFT+- = _
  { key = '|', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '_', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Resize step: ctrl+shift+alt+arrows (matches kitty/ghostty)
  { key = 'RightArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Right', 3 } },
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Left',  3 } },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Up',    3 } },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Down',  3 } },

  -- Tab reorder: ctrl+shift+,/. (matches kitty/ghostty)
  -- WezTerm sees the shifted character: SHIFT+, = <, SHIFT+. = >
  { key = '<', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(-1) },
  { key = '>', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(1) },

  -- New tab: Ctrl+Shift+T cross-platform (Cmd+T already default)
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },

  -- Close pane: Ctrl+Shift+W cross-platform + Cmd+W macOS alias
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = 'w', mods = 'SUPER',      action = wezterm.action.CloseCurrentPane { confirm = true } },

  -- Close tab: Ctrl+Shift+Q cross-platform + Cmd+Shift+W macOS alias
  { key = 'q', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true } },
  { key = 'w', mods = 'SUPER|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true } },

  -- Zoom pane: Ctrl+Shift+Z (cross-platform, all terminals)
  { key = 'z', mods = 'CTRL|SHIFT', action = wezterm.action.TogglePaneZoomState },

  -- Tmux CSI sequences: Ctrl+Super+digit (replaces Super+digit — Win+1-9 conflicts with GNOME)
  { key = '1', mods = 'CTRL|SUPER', action = wezterm.action.SendString '\x1b[49;9u' },
  { key = '2', mods = 'CTRL|SUPER', action = wezterm.action.SendString '\x1b[50;9u' },
  { key = '3', mods = 'CTRL|SUPER', action = wezterm.action.SendString '\x1b[51;9u' },
  { key = '4', mods = 'CTRL|SUPER', action = wezterm.action.SendString '\x1b[52;9u' },
  { key = '5', mods = 'CTRL|SUPER', action = wezterm.action.SendString '\x1b[53;9u' },
  { key = '6', mods = 'CTRL|SUPER', action = wezterm.action.SendString '\x1b[54;9u' },
  { key = '7', mods = 'CTRL|SUPER', action = wezterm.action.SendString '\x1b[55;9u' },
  { key = '8', mods = 'CTRL|SUPER', action = wezterm.action.SendString '\x1b[56;9u' },
  { key = '9', mods = 'CTRL|SUPER', action = wezterm.action.SendString '\x1b[57;9u' },
  { key = '0', mods = 'CTRL|SUPER', action = wezterm.action.SendString '\x1b[48;9u' },

  -- Tab by index: Alt+1-9 (cross-platform, GNOME-safe)
  { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },

  -- Disable Super+1-9 defaults (Win+1-9 conflicts with GNOME workspace/dock shortcuts)
  { key = '1', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },
  { key = '2', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },
  { key = '3', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },
  { key = '4', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },
  { key = '5', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },
  { key = '6', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },
  { key = '7', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },
  { key = '8', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },
  { key = '9', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },

  -- Disable Super+N default (Win+N conflicts with GNOME notification center)
  { key = 'n', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },

  -- Resize panes (modal: LEADER+r then hjkl)
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_panes',
      one_shot = false,
      timeout_milliseconds = 350,
    },
  },

  { key = 'Enter', mods = 'SHIFT',     action = wezterm.action.SendString '\x1b\r' },
  { key = 'f',     mods = 'SHIFT|CTRL', action = wezterm.action.DisableDefaultAssignment },
}

config.key_tables = {
  resize_panes = {
    resize_pane('h', 'Left'),
    resize_pane('j', 'Down'),
    resize_pane('k', 'Up'),
    resize_pane('l', 'Right'),
    -- Arrow keys also work in modal mode
    resize_pane('LeftArrow',  'Left'),
    resize_pane('DownArrow',  'Down'),
    resize_pane('UpArrow',    'Up'),
    resize_pane('RightArrow', 'Right'),
  },
}

config.enable_wayland = false
config.enable_kitty_keyboard = true

-- and finally, return the configuration to wezterm
return config
