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
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  require("plugins.configs.lsp.keymaps").setup(client, bufnr)

  if client.name == "sumneko_lua" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  if client.name == "solargraph" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  -- tagfunc
  if client.server_capabilities.definitionProvider then
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  end

  if client.supports_method "textDocument/codeLens" then
    utils.buf_autocmd_codelens(client)
    vim.schedule(vim.lsp.codelens.refresh)
  end
  if client.supports_method "textDocument/documentHighlight" then
    utils.lsp_highlight_document(client, bufnr)
  end
  -- nvim-navic
  if client.server_capabilities.documentSymbolProvider then
    local navic = prequire "nvim-navic"
    if not navic then
      return
    end
    navic.attach(client, bufnr)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

require("plugins.configs.lsp.handlers").setup()

function M.setup()
  require "plugins.configs.lsp.lsp-signature"
  require "plugins.configs.lsp.lsp-installer"
end

return M
