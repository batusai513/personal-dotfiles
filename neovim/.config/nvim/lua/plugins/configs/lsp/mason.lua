local M = {}

function M.setup()
  local ok_mason, mason = pcall(require, "mason")

  mason.setup {}
end

return M
