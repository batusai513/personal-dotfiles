local M = {}

function M.setup()
  local gitsigns = prequire "gitsigns"
  if not gitsigns then
    return
  end
  local options = {}

  options = require("core.utils").load_override(options, "lewis6991/gitsigns.nvim")
  gitsigns.setup(options)
end

return M
