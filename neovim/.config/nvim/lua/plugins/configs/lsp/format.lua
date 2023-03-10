require("core.utils").on_attach(function(_, buffer)
  vim.api.nvim_buf_create_user_command(buffer, "Format", function()
    vim.lsp.buf.format {
      async = true,
      bufnr = buffer,
    }
  end, {})
end)
