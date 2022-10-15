local M = {}

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

return M
