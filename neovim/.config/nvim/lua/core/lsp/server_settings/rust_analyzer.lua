return function(server, opts)
  local rustopts = {
    tools = {
      autoSetHints = true,
      hover_with_actions = true,
    },
    server = vim.tbl_deep_extend("force", server:get_default_options(), opts, {}),
  }
  require("rust-tools").setup(rustopts)
  server:attach_buffers()
end
