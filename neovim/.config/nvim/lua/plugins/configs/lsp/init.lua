local lspConfig = prequire "lspconfig"
if not lspConfig then
  return
end

require "plugins.configs.lsp.lsp-signature"
require "plugins.configs.lsp.lsp-installer"
require("plugins.configs.lsp.handlers").setup()
