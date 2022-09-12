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
    lua_dev.setup()
  end

  server:setup(vim.tbl_deep_extend("force", opts, default_opts))
end
