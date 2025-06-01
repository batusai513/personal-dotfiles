---@class utils.lsp.attach_lsp_keymaps
local M = {}

M._keys = nil

function M.get()
  if M._keys then
    return M._keys
  end

  --stylua: ignore
  M._keys = {
    { "gd", vim.lsp.buf.definition, desc = "[G]oto [D]efinition", has = "definition" },
    { "gr", vim.lsp.buf.references, desc = "References" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "K", vim.lsp.buf.hover, desc = "Hover" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
    { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename', has = 'rename' },
    {
      "<leader>cA",
      function()
        vim.lsp.buf.code_action({
          context = {
            only = {
              "source",
            },
            diagnostics = {},
          },
        })
      end,
      desc = "Source Action",
      has = "codeAction",
    },
  }

  return M._keys
end

---@param method string
function M.support_handler(buffer, method)
  method = method:find '/' and method or 'textDocument/' .. method
  local clients = require('utils.lsp.init').get_clients { bufnr = buffer }
  for _, client in ipairs(clients) do
    if client:supports_method(method) then
      return true
    end
  end
  return false
end

---@param buffer any
---@return (LazyKeys|{has?:string})[]
function M.resolve(buffer)
  local Keys = require 'lazy.core.handler.keys'
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  return Keys.resolve(spec)
end

function M.attach_lsp_keymaps(_, buffer)
  local Keys = require 'lazy.core.handler.keys'
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.support_handler(buffer, keys.has) then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or 'n', keys.lhs, keys.rhs, opts)
    end
  end
end

return M
