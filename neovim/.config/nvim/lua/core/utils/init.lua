local M = {}

function M.merge(...)
  return vim.tbl_deep_extend('force', ...)
end

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = M.merge(options, opts)
  end
  --vim.keymap.set("mode", lhs, rhs, {buffer})
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
