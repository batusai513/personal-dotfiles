local Util = require 'custom.utils'
local M = {}

---@class CapabilityOptions
---@field enabled boolean

---@class AttachOptions
---@field inlay_hints CapabilityOptions
---@field codelens CapabilityOptions

---on_attach function run when a lsp client attach to a buffer
---@param client lsp.Client LSP client details
---@param buffer integer, The buffer that the lsp client attachs to
---@param opts AttachOptions
function M.on_attach(client, buffer, opts)
  -- inlay hints
  if opts.inlay_hints.enabled then
    Util.lsp.on_attach(function(client, buffer)
      if client.supports_method 'textDocument/inlayHint' then
        Util.toggle.inlay_hints(buffer, true)
      end
    end)
  end

  -- code lens
  if opts.codelens.enabled and vim.lsp.codelens then
    Util.lsp.on_attach(function(client, buffer)
      if client.supports_method 'textDocument/codeLens' then
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
          buffer = buffer,
          callback = vim.lsp.codelens.refresh,
        })
      end
    end)
  end

  -- documentHighlight
  if client.supports_method 'textDocument/documentHighlight' then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = buffer,
      desc = 'Document Highlighting',
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = buffer,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
