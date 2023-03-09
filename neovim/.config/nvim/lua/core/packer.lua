local M = {}

M.run = function(plugins)
  plugins = require("core.utils").merge_plugins(plugins)
  return plugins
end

return M
