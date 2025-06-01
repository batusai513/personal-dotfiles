---@class utils.lsp
local M = {}

---@alias vim.lsp.Client.filter {id?: number, bufnr?: number, name?: string, method?: string, filter?:fun(client: vim.lsp.Client):boolean}
---@param opts? vim.lsp.Client.filter
function M.get_clients(opts)
  local ret = {} ---@type vim.lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ret = vim.lsp.get_clients(opts)
    if opts and opts.method then
      ---@param client vim.lsp.Client
      ret = vim.tbl_filter(function(client)
        return client:supports_method(opts.method, opts.bufnr)
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

---Attach a callback to the LspAttach event
---@param on_attach_fn fun(client, buffer)
function M.on_attach(on_attach_fn)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf --@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach_fn(client, buffer)
    end,
  })
end

M.options = {
  diagnostics = {
    update_in_insert = true,
    underline = true,
    float = {
      focused = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
    virtual_text = false,
    severity_sort = true,
  },
  -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
  -- Be aware that you also will need to properly configure your LSP server to
  -- provide the inlay hints.
  inlay_hints = {
    enabled = false,
  },
  -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
  -- Be aware that you also will need to properly configure your LSP server to
  -- provide the code lenses.
  codelens = {
    enabled = false,
  },
  -- add any global capabilities here
  capabilities = {},
  -- options for vim.lsp.buf.format
  -- `bufnr` and `filter` is handled by the LazyVim formatter,
  -- but can be also overridden when specified
  format = {
    formatting_options = nil,
    timeout_ms = nil,
  },
}

return M
