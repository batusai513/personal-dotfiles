local M = {}

function M.setup(lspconfig)
  local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")

  mason_lspconfig.setup {
    ensure_installed = {
      "astro",
      "rust_analyzer",
      "solargraph",
      "sumneko_lua",
      "tailwindcss",
      "taplo",
      "tsserver",
      "cssls",
      "dockerls",
      "emmet_ls",
      "eslint",
      "groovyls",
      "html",
      "jsonls",
      "prosemd_lsp",
      "vimls",
      "yamlls",
    },
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      local opts = {
        on_attach = require("plugins.configs.lsp").on_attach,
        capabilities = require("plugins.configs.lsp").capabilities,
      }
      local has_custom_config, server_custom_config = pcall(
        require,
        "plugins.configs.lsp.server_settings." .. server_name
      )
      if has_custom_config then
        if type(server_custom_config) == "function" then
          return server_custom_config(lspconfig[server_name], opts)
        else
          opts = vim.tbl_deep_extend("force", {}, opts, server_custom_config)
        end
      end

      lspconfig[server_name].setup(opts)
    end,
  }
end

return M
