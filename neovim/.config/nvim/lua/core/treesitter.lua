local treesitter_configs = prequire "nvim-treesitter.configs"

if not treesitter_configs then
  return
end

treesitter_configs.setup {
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
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
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
    enable = true,
    extended_mode = true,
  },
}
