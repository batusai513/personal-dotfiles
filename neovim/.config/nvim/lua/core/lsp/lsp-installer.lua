local lsp_installer = prequire "nvim-lsp-installer"

if not lsp_installer then
  return
end

local function on_server_ready(server)
  local opts = {
    on_attach = require("core.lsp.default_attach").on_attach,
    capabilities = require("core.lsp.capabilities").capabilities,
  }

  local server_overrides = prequire("core.lsp.server_settings." .. server.name)
  if server_overrides then
    opts = vim.tbl_deep_extend("force", server_overrides, opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end

lsp_installer.on_server_ready(on_server_ready)
