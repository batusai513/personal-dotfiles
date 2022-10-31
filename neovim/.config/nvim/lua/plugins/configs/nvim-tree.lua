local icons = require "core.theme.icons"

local nvim_tree = prequire "nvim-tree"
if not nvim_tree then
  return
end

local nvim_tree_config = prequire "nvim-tree.config"
if not nvim_tree_config then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

local diagnosticsConfig = {
  enable = true,
  icons = {
    hint = icons.hint,
    info = icons.info,
    warning = icons.warning,
    error = icons.error,
  },
}

local config = {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = false,
  ignore_buffer_on_setup = false,
  create_in_closed_folder = true,
  auto_reload_on_write = true,
  open_on_tab = false,
  diagnostics = diagnosticsConfig,
  hijack_directories = {
    enable = false,
    auto_open = false,
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  filesystem_watchers = {
    enable = false,
  },
  view = {
    width = 25,
    side = "right",
    hide_root_folder = false,
    adaptive_size = true,
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },
  renderer = {
    highlight_git = true,
    root_folder_modifier = ":t",
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
      glyphs = {
        default = "",
        symlink = icons.kind.Reference,
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          -- arrow_open = " ",
          -- arrow_closed = "",
          default = icons.misc.folder_default,
          open = icons.misc.folder_open,
          empty = icons.misc.folder_empty,
          empty_open = icons.misc.folder_empty_open,
          symlink = icons.misc.folder_symlink,
        },
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = { ".cache" },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  actions = {
    change_dir = {
      enable = false,
      global = false,
      restrict_above_cwd = true,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
    },
  },
}

nvim_tree.setup(config)
