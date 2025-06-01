local Util = require 'utils.init'

---@class utils.lsp.attach_lsp_capabilities
local M = {}

---@class CapabilityOptions
---@field enabled boolean

---@class AttachOptions
---@field inlay_hints CapabilityOptions
---@field codelens CapabilityOptions

---on_attach function run when a lsp client attach to a buffer
---@param init_client vim.lsp.Client LSP client details
---@param init_buffer integer, The buffer that the lsp client attachs to
---@param opts AttachOptions
function M.attach_lsp_capabilities(init_client, init_buffer, opts)
  -- inlay hints
  if opts.inlay_hints.enabled then
    ---@param client vim.lsp.Client LSP client details
    ---@param buffer integer, The buffer that the lsp client attachs to
    Util.lsp.on_attach(function(client, buffer)
      if client:supports_method 'textDocument/inlayHint' then
        Util.toggle.inlay_hints(buffer, true)
      end
    end)
  end

  -- code lens
  if opts.codelens.enabled and vim.lsp.codelens then
    ---@param client vim.lsp.Client LSP client details
    ---@param buffer integer, The buffer that the lsp client attachs to
    Util.lsp.on_attach(function(client, buffer)
      if client:supports_method 'textDocument/codeLens' then
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
          buffer = buffer,
          callback = vim.lsp.codelens.refresh,
        })
      end
    end)
  end

  -- documentHighlight
  if init_client:supports_method 'textDocument/documentHighlight' then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = init_buffer,
      desc = 'Document Highlighting',
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = init_buffer,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
