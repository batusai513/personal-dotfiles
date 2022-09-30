local treesitter_configs = prequire "nvim-treesitter.configs"

if not treesitter_configs then
  return
end

local M = {}

function M.setup()
  local options = {
    ensure_installed = {
      "css",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "markdown",
      "php",
      "python",
      "scss",
      "tsx",
      "typescript",
      "ruby",
    },
    sync_install = false,
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    autotag = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    refactor = {
      highlight_definitions = { enable = true },
      highlight_current_scope = { enable = false },
    },
    rainbow = {
      enable = false,
      extended_mode = true,
    },
  }

  options = require("core.utils").load_override(options, "nvim-treesitter/nvim-treesitter")

  treesitter_configs.setup(options)
end

return M
