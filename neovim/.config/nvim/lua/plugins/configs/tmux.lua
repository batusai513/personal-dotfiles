local M = {}
local tmux = prequire "tmux"
if not tmux then
  return
end

function M.setup()
  require("tmux").setup {}
end

return M
