local group = vim.api.nvim_create_augroup("lsp_document_highlight", {})

local function buf_autocmd_document_highlight(bufnr)
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    group = group,
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
    local bufnr = args.buf

    if client.supports_method "textDocument/documentHighlight" then
      buf_autocmd_document_highlight(bufnr)
    end
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = group,
    }
  end,
})
