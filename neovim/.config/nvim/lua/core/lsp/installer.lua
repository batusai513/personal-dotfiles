local mason = prequire "mason"
local mason_lspconfig = prequire "mason-lspconfig"
local u = require "core.utils"

if not mason or not mason_lspconfig then
  return
end

mason.setup()

mason_lspconfig.setup {
  ensure_installed = {
    "solargraph",
    "sumneko_lua",
    "tsserver",
    "eslint",
    "jsonls",
    "yamlls",
    "emmet_ls",
    "rust_analyzer",
  },
}

local global_opts = {
  on_attach = require("core.lsp.default_attach").on_attach,
  capabilities = require("core.lsp.capabilities").capabilities,
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup(global_opts)
  end,
  ["emmet_ls"] = function()
    local opts = require "core.lsp.server_settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", opts, global_opts)
    require("lspconfig")["emmet_ls"].setup(opts)
  end,
  ["eslint"] = function()
    local opts = require "core.lsp.server_settings.eslint"
    opts = vim.tbl_deep_extend("force", opts, global_opts)
    require("lspconfig")["eslint"].setup(opts)
  end,
  ["jsonls"] = function()
    local opts = require "core.lsp.server_settings.jsonls"
    opts = vim.tbl_deep_extend("force", opts, global_opts)
    require("lspconfig")["jsonls"].setup(opts)
  end,
  ["pyright"] = function()
    local opts = require "core.lsp.server_settings.pyright"
    opts = vim.tbl_deep_extend("force", opts, global_opts)
    require("lspconfig")["pyright"].setup(opts)
  end,
  ["rust_analyzer"] = function()
    local create_opts = require "core.lsp.server_settings.rust_analyzer"
    local opts = create_opts(global_opts)
    local ok, rust_tools = pcall(require, "rust-tools")
    if ok then
      rust_tools.setup(opts)
    end
  end,
  ["sumneko_lua"] = function()
    local neodev_loaded, neodev = pcall(require, "neodev")
    if neodev_loaded then
      neodev.setup {}
    end
    require("lspconfig")["sumneko_lua"].setup(u.merge(global_opts, {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    }))
  end,
  ["tsserver"] = function()
    local create = require "core.lsp.server_settings.tsserver"
    create(global_opts)
  end,
}
