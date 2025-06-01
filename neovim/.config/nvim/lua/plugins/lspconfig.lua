return {
  {
    'yioneko/nvim-vtsls',
    ft = {
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
    },
  },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    dependencies = { 'neovim/nvim-lspconfig' },
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'mason.nvim' },
      { 'mason-org/mason-lspconfig.nvim' },
    },
  },
  {
    'mason-org/mason.nvim',
    version = '^2',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' },
    },
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'stylua',
        'shfmt',
      },
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    version = '^2',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      automatic_enable = true,
      ensure_installed = { 'vtsls', 'lua_ls', 'rust_analyzer' },
    },
    dependencies = {
      { 'mason-org/mason.nvim' },
      { 'neovim/nvim-lspconfig' },
    },
  },
}
