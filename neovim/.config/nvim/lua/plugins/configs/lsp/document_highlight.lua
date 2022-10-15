local function lsp_highlight_document(bufnr)
  -- Set autocommands conditional on server_capabilities
  -- vim.cmd [[
  --   hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
  --   hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
  --   hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  -- ]]
  vim.api.nvim_create_augroup("lsp_document_highlight", {
    clear = false,
  })
  vim.api.nvim_clear_autocmds {
    buffer = bufnr,
    group = "lsp_document_highlight",
  }
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    group = "lsp_document_highlight",
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = bufnr,
    group = "lsp_document_highlight",
    callback = vim.lsp.buf.clear_references,
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.documentHighlightProvider then
      lsp_highlight_document(args.buf)
    end
  end,
})
