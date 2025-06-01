return {
  settings = {
    Lua = {
      completion = { callSnippet = 'Replace' },
      diagnostics = { globals = { 'vim' } },
      format = { enable = false },
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
      },
    },
  },
}
