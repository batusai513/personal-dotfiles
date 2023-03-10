local treesitter_configs = prequire "nvim-treesitter.configs"

if not treesitter_configs then
  return
end

local M = {}

function M.setup()
  local options = {
    ensure_installed = {
      "bash",
      "css",
      "html",
      "javascript",
      "json",
      "json5",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "php",
      "python",
      "ruby",
      "scss",
      "tsx",
      "typescript",
      "vim",
      "yaml",
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
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<nop>",
        node_decremental = "<bs>",
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
