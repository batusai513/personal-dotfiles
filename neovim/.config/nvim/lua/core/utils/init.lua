local M = {}

function M.merge(...)
  return vim.tbl_deep_extend("force", ...)
end
function M.set_keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = M.merge(options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

return M
