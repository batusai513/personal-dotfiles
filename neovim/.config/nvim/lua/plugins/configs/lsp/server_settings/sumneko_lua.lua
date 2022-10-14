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
  local neodev_loaded, neodev = pcall(require, "neodev")
  if neodev_loaded then
    neodev.setup {}
  end

  server.setup(vim.tbl_deep_extend("force", {}, opts, default_opts))
end
