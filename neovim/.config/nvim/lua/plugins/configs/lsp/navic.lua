local M = {}

function M.setup()
  local ok, navic = pcall(require, "nvim-navic")

  if not ok then
    vim.pretty_print "cannot find navic"
    return
  end

  local options = {}

  options = require("core.utils").load_override(options, "SmiteshP/nvim-navic")

  navic.setup(options)

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, args.buf)
      end
    end,
  })
end

return M
