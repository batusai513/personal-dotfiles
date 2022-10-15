vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.api.nvim_buf_create_user_command(args.buf, "Format", function()
      vim.lsp.buf.format {
        async = true,
        bufnr = args.buf,
      }
    end, {})
  end,
})
