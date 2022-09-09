local M = {}

--- @return fun() @function that calls the provided fn, but with no args
local function w(fn)
  return function()
    return fn()
  end
end

function M.buf_autocmd_codelens(client, bufnr)
  if client.resolved_capabilities.code_lens then
    local group = vim.api.nvim_create_augroup("lsp_document_codelens", {})
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost", "CursorHold" }, {
      buffer = bufnr,
      group = group,
      callback = w(vim.lsp.codelens.refresh),
    })
  end
end

-- Finds and runs the closest codelens (searches upwards only)
function M.find_and_run_codelens()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local lenses = vim.lsp.codelens.get(bufnr)

  lenses = vim.tbl_filter(function(lense)
    return lense.range.start.line < row
  end, lenses)

  if #lenses == 0 then
    return vim.api.nvim_echo({ { "Could not find codelens to run.", "WarningMsg" } }, false, {})
  end

  table.sort(lenses, function(a, b)
    return a.range.start.line > b.range.start.line
  end)

  vim.api.nvim_win_set_cursor(0, { lenses[1].range.start.line + 1, lenses[1].range.start.character })
  vim.lsp.codelens.run()
  -- vim.api.nvim_win_set_cursor(0, { row, col }) -- restore cursor, TODO: also restore position
end

function M.lsp_highlight_document(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  local group = vim.api.nvim_create_augroup("lsp_document_highlight", {})
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    group = group,
    callback = w(vim.lsp.buf.document_highlight),
  })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = bufnr,
    group = group,
    callback = w(vim.lsp.buf.clear_references),
  })
end

return M
