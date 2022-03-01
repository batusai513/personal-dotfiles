local treesitter_configs = prequire("nvim-treesitter.configs")

if not treesitter_configs then return end

treesitter_configs.setup {
  ensure_installed = {
    'css',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'markdown',
    'php',
    'python',
    'scss',
    'tsx',
    'typescript',
  },
  sync_install = false,
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
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
  }
}
