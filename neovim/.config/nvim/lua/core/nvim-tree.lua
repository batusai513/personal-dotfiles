local icons = require("core.theme.icons")

vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_root_folder_modifier = ":t"
vim.g.nvim_tree_create_in_closed_folder = 1
vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}
vim.g.nvim_tree_icons = {
  default = "",
  symlink = icons.symlink,
  git = icons.git,
  folder = icons.folder,
  lsp = {
    hint = icons.hint,
    info = icons.info,
    warning = icons.warn,
    error = icons.error,
  },
}

local nvim_tree = prequire("nvim-tree")
if not nvim_tree then return end

local nvim_tree_config = prequire("nvim-tree.config")
if not nvim_tree_config then return end

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
  ignore_buffer_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  auto_reload_on_write = true,
  hijack_unnamed_buffer_when_opening = false,
  hijack_directories = {
    enable = false,
    auto_open = false,
	},
  auto_close = false,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  diagnostics = diagnosticsConfig,
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
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
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "right",
    auto_resize = false,
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
	filters = {
		dotfiles = false,
		custom = { "node_modules", ".cache" },
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	actions = {
		change_dir = {
			global = false,
		},
		open_file = {
			quit_on_open = false,
		},
		window_picker = {
			enable = true,
			chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
      exclude = {
        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
        buftype  = { "nofile", "terminal", "help", },
      }
		},
	},
  quit_on_open = 0,
}

nvim_tree.setup(config)
