local lspConfig = prequire "lspconfig"
if not lspConfig then
  return
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not status_ok then
  print "could not load cmp_nvim_lsp"
  return
end

local utils = require "plugins.configs.lsp.utils"

local M = {}

function M.on_attach(client, bufnr)
  require("plugins.configs.lsp.keymaps").setup(client, bufnr)

  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == "solargraph" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.supports_method "textDocument/codeLens" then
    utils.buf_autocmd_codelens(client)
    vim.schedule(vim.lsp.codelens.refresh)
  end
  if client.supports_method "textDocument/documentHighlight" then
    utils.lsp_highlight_document(client, bufnr)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

require("plugins.configs.lsp.handlers").setup()

function M.setup()
  require("plugins.configs.lsp.installer").setup(lspConfig)
end

return M
