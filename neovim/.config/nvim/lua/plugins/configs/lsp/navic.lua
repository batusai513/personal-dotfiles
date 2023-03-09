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

  require("core.utils").on_attach(function(client, buffer)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, buffer)
    end
  end)end

return M
