return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    keys = { ':', '/', '?' },
    version = '1.*',
    dependencies = {
      -- { 'L3MON4D3/LuaSnip', version = 'v2.*' },
      { 'rafamadriz/friendly-snippets' },
    },
    opts = {
      snippets = { preset = 'default' },
      -- snippets = { preset = 'luasnip' },
      -- ensure you have the `snippets` source (enabled by default)
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        sorts = {
          'exact',
          -- defaults
          'score',
          'sort_text',
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      completion = {
        menu = {},
        documentation = {
          window = {},
        },
      },
      signature = {
        enabled = true,
        window = {},
      },
      keymap = {
        preset = 'enter',
        ['<C-y>'] = { 'select_and_accept' },
      },
    },
  },
}
