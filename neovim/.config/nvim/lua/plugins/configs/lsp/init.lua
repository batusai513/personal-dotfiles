local M = {}

require("plugins.configs.lsp.handlers").setup()

function M.setup()
  require("plugins.configs.lsp.installer").setup(require("lspconfig"))
  require "plugins.configs.lsp.server_overrides"
  require "plugins.configs.lsp.keymaps"
  require "plugins.configs.lsp.format"
  require "plugins.configs.lsp.document_highlight"
  require "plugins.configs.lsp.codelens"
end

return M
