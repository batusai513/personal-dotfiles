return function(server, default_opts)
  local neodev_loaded, neodev = pcall(require, "neodev")
  if neodev_loaded then
    neodev.setup {}
  end

  local opts = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  }

  server.setup(vim.tbl_deep_extend("force", {}, opts, default_opts))
end
