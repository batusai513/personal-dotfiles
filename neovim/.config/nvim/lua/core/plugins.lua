local M = {}

M.merge = function(plugins)
  plugins = require("core.utils").merge_plugins(plugins)
  return plugins
end

return M
