local M = {}

---Run the callback fn on VeryLazy event
---@param fn function
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      fn()
    end,
  })
end

---Checks if the plugin is installed
---@param plugin string
function M.plugin_installed(plugin)
  return require('lazy.core.config').spec.plugins[plugin] ~= nil
end

---Get installed plugin opts from spec
---@param name string
function M.get_plugin_options(name)
  local plugin = require('lazy.core.config').plugins[name]
  if not plugin then
    return {}
  end

  local Plugin = require 'lazy.core.plugin'
  return Plugin.values(plugin, 'opts', false)
end

return M
