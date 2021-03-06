local lspConfig = prequire "lspconfig"
if not lspConfig then
  return
end

require "core.lsp.lsp-signature"
require "core.lsp.lsp-installer"
require("core.lsp.diagnostics").init()
require("core.lsp.handlers").setup()
