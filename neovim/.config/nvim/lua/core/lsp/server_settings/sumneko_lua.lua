local opts = {
  settings = {
    Lua = {
      workspace = {
        library = {
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
}

return function(server, default_opts)
  local lua_dev_loaded, lua_dev = pcall(require, "lua-dev")
  if lua_dev_loaded then
    local dev_opts = {
      library = {
        vimruntime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        -- plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        plugins = { "plenary.nvim" },
      },
      lspconfig = vim.tbl_deep_extend("force", opts, default_opts),
    }

    opts = lua_dev.setup(dev_opts)
  end

  server:setup(opts)
end
