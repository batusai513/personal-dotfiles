local M = {}

---@param client vim.lsp.Client LSP client details
---@param method string
M.client_supports = function(client, method)
  method = method:find '/' and method or 'textDocument/' .. method
  return client:supports_method(method)
end

return M
