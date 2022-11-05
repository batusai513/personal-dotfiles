local lspConfig = prequire "lspconfig"
if not lspConfig then
  return
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not status_ok then
  print "could not load cmp_nvim_lsp"
  return
end

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

require("plugins.configs.lsp.handlers").setup()

function M.setup()
  require("plugins.configs.lsp.installer").setup(lspConfig)
  require "plugins.configs.lsp.server_overrides"
  require "plugins.configs.lsp.keymaps"
  require "plugins.configs.lsp.format"
  require "plugins.configs.lsp.document_highlight"
  require "plugins.configs.lsp.codelens"
end

return M
