return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    keys = { ':', '/', '?' },
    version = '^1.*',
    dependencies = {
      -- { 'L3MON4D3/LuaSnip', version = 'v2.*' },
      { 'rafamadriz/friendly-snippets' },
    },
    opts = {
      snippets = { preset = 'default' },
      -- snippets = { preset = 'luasnip' },
      -- ensure you have the `snippets` source (enabled by default)
      fuzzy = { implementation = 'prefer_rust' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      completion = {
        menu = { border = 'single' },
        documentation = { window = { border = 'single' } },
      },
      signature = {
        enabled = true,
        window = { border = 'single' },
      },
      keymap = {
        preset = 'enter',
        ['<C-y>'] = { 'select_and_accept' },
      },
    },
  },
}
