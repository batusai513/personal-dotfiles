return function(server, default_opts)
  local ok, typescript = pcall(require, "typescript")
  if ok then
    local dev_opts = {
      debug = false,
      server = vim.tbl_deep_extend("force", server:get_default_options(), default_opts),
    }
    typescript.setup(dev_opts)
    server:attach_buffers()
  end
end
