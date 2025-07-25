local LazyUtil = require 'lazy.core.util'

---@class lsp_utils : utils.lsp
---@field attach_lsp_keymaps utils.lsp.attach_lsp_keymaps
---@field attach_lsp_capabilities utils.lsp.attach_lsp_capabilities

---@class utils: LazyUtilCore
---@field toggle utils.toggle
---@field ui utils.ui
---@field lsp lsp_utils
local M = {}

-- Dynamically load other modules in LazyUtil or other modules
-- in this folder
setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require('utils.' .. k)
    return t[k]
  end,
})

function M.is_win()
  return vim.loop.os_uname().sysname:find 'Windows' ~= nil
end

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
