local telescope = prequire "telescope"
if not telescope then
  return
end

local _, builtin = pcall(require, "telescope.builtin")
local actions = require "telescope.actions"

local default_mappings = {
  n = {
    ["Q"] = actions.smart_add_to_qflist + actions.open_qflist,
    ["q"] = actions.smart_send_to_qflist + actions.open_qflist,
    ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
    ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
    ["v"] = actions.file_vsplit,
    ["s"] = actions.file_split,
    ["<cr>"] = actions.file_edit,
    ["<C-n>"] = actions.move_selection_next,
    ["<C-p>"] = actions.move_selection_previous,
  },
  i = {
    ["<C-n>"] = actions.move_selection_next,
    ["<C-p>"] = actions.move_selection_previous,
    ["<C-c>"] = actions.close,
    ["<C-j>"] = actions.cycle_history_next,
    ["<C-k>"] = actions.cycle_history_prev,
    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
    ["<CR>"] = actions.select_default,
  },
}

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = default_mappings,
  },

  extensions_list = { "themes", "terms" },
}
local M = {}

M.project_files = function()
  local ok = pcall(builtin.git_files, { show_untracked = true })
  if not ok then
    builtin.find_files()
  end
end

options = require("core.utils").load_override(options, "nvim-telescope/telescope.nvim")

M.setup = function()
  telescope.setup(options)
  require("telescope").load_extension "fzf"
  require("telescope").load_extension "ui-select"

  local map = require("core.utils").set_keymap

  -- navigation
  map("n", "<leader>sf", M.project_files)
  map("n", "<leader>sh", builtin.help_tags)
  map("n", "<leader>sM", builtin.man_pages)
  map("n", "<leader>sr", builtin.oldfiles)
  map("n", "<leader>sR", builtin.registers)
  map("n", "<leader>sB", builtin.buffers)
  map("n", "<leader>st", builtin.live_grep)
  map("n", "<leader>sk", builtin.keymaps)
  map("n", "<leader>sC", builtin.commands)
  map("n", "<leader>sc", function()
    require("telescope.builtin.internal").colorscheme { enable_preview = true }
  end)
end

return M
