return function(server, opts)
  local rustopts = {
    tools = {
      autoSetHints = true,
      hover_with_actions = true,
    },
    server = vim.tbl_deep_extend("force", server:get_default_options(), opts, {}),
  }
  local ok, rust_tools = pcall(require, "rust-tools")
  if ok then
    rust_tools.setup(rustopts)
    server:attach_buffers()
  end
end
