local telescope = prequire "telescope"
if not telescope then
  return
end

local _, builtin = pcall(require, "telescope.builtin")
local actions = require "telescope.actions"
local icons = require "core.theme.icons"
local u = require "core.utils"

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

local opts_cursor = {
  initial_mode = "normal",
  sorting_strategy = "ascending",
  layout_strategy = "cursor",
  results_title = false,
  layout_config = {
    width = 0.5,
    height = 0.4,
  },
}

local opts_vertical = {
  initial_mode = "normal",
  sorting_strategy = "ascending",
  layout_strategy = "vertical",
  results_title = false,
  layout_config = {
    width = 0.4,
    height = 0.5,
    prompt_position = "top",
    mirror = true,
  },
}

local opts_flex = {
  layout_strategy = "flex",
  layout_config = {
    width = 0.7,
    height = 0.7,
  },
}

local options = u.merge({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = icons.folder.arrow_closed,
    file_ignore_patterns = {
      ".git/",
    },
    dynamic_preview_title = true,
    vimgrep_arguments = {
      "rg",
      "--ignore",
      "--hidden",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
      "--glob=!.git/",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
  pickers = {
    buffers = u.merge(opts_vertical, {
      prompt_title = "✨ Search Buffers ✨",
      mappings = u.merge({
        n = {
          ["d"] = actions.delete_buffer,
        },
      }, default_mappings),
      sort_mru = true,
      preview_title = false,
      previewer = false,
    }),
    lsp_code_actions = u.merge(opts_cursor, {
      prompt_title = "Code Actions",
      previewer = false,
    }),
    lsp_range_code_actions = u.merge(opts_vertical, {
      prompt_title = "Code Actions",
      previewer = false,
    }),
    lsp_implementations = u.merge(opts_cursor, {
      prompt_title = "Implementations",
      mappings = default_mappings,
    }),
    lsp_definitions = u.merge(opts_cursor, {
      prompt_title = "Definitions",
      mappings = default_mappings,
    }),
    lsp_references = u.merge(opts_vertical, {
      prompt_title = "References",
      mappings = default_mappings,
    }),
    diagnostics = u.merge({
      mappings = default_mappings,
      theme = "ivy",
    }, {}),
    find_files = u.merge(opts_flex, {
      prompt_title = "✨ Search Project ✨",
      find_command = { "fd", "--type=file", "--hidden", "--smart-case" },
      mappings = default_mappings,
      hidden = true,
    }),
    git_files = u.merge(opts_flex, {
      prompt_title = "✨ Search Git Project ✨",
      mappings = default_mappings,
      hidden = true,
    }),
    live_grep = u.merge(opts_flex, {
      prompt_title = "✨ Live Grep ✨",
      mappings = default_mappings,
      only_sort_text = true,
    }),
    grep_string = u.merge(opts_vertical, {
      prompt_title = "✨ Grep String ✨",
      mappings = default_mappings,
      initial_mode = "insert",
    }),
  },
}, {})

local M = {}

M.project_files = function()
  local ok = pcall(builtin.git_files)
  if not ok then
    builtin.find_files()
  end
end

M.init = function()
  telescope.setup(options)
  require("telescope").load_extension "fzf"
  require("telescope").load_extension "ui-select"

  local map = require("core.utils").set_keymap

  local opts = {}
  -- navigation
  map("n", "<leader>sf", require("core.telescope").project_files)
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
