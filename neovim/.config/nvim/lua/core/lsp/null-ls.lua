local null_ls = prequire "null-ls"
if not null_ls then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = true,
  sources = {
    formatting.prettier.with {
      prefer_local = "node_modules/.bin",
    },
    -- diagnostics.eslint_d.with {
    --   prefer_local = 'node_modules/.bin'
    -- },
    -- code_actions.eslint_d.with {
    --   prefer_local = 'node_modules/.bin'
    -- },
    formatting.stylua,
    code_actions.gitsigns,
  },
}
