local M = {}

local api = vim.api

local merge_tb = vim.tbl_deep_extend

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

M.load_config = function()
  local config = require "core.default_config"
  local customrc_exist, customrc = pcall(require, "custom.customrc")

  if customrc_exist then
    if type(customrc) == "table" then
      config = merge_tb("force", config, customrc) or {}
    else
      error "customrc must return a table"
    end
  end

  return config
end

-- merge default/user plugin tables
M.merge_plugins = function(default_plugins)
  local user_plugins = M.load_config().plugins.user

  -- merge default + user plugin table
  default_plugins = merge_tb("force", default_plugins, user_plugins)

  local final_table = {}

  for key, _ in pairs(default_plugins) do
    default_plugins[key][1] = key
    final_table[#final_table + 1] = default_plugins[key]
  end

  return final_table
end

M.load_override = function(default_table, plugin_name)
  local user_table = M.load_config().plugins.override[plugin_name] or {}
  user_table = type(user_table) == "table" and user_table or user_table()
  return merge_tb("force", default_table, user_table) or {}
end

M.packer_sync = function(...)
  local git_exists, git = pcall(require, "nvchad.utils.git")
  local defaults_exists, defaults = pcall(require, "nvchad.utils.config")
  local packer_exists, packer = pcall(require, "packer")

  if git_exists and defaults_exists then
    local current_branch_name = git.get_current_branch_name()

    -- warn the user if we are on a snapshot branch
    if current_branch_name:match(defaults.snaps.base_snap_branch_name .. "(.+)" .. "$") then
      vim.api.nvim_echo({
        { "WARNING: You are trying to use ", "WarningMsg" },
        { "PackerSync" },
        {
          " on a Snapshot. This will cause issues if Dotfiles dependencies contain "
            .. "any breaking changes! Plugin updates will not be included in this "
            .. "snapshot, so they will be lost after switching between snapshots! Would "
            .. "you still like to continue? [y/N]\n",
          "WarningMsg",
        },
      }, false, {})

      local ans = vim.trim(string.lower(vim.fn.input "-> "))

      if ans ~= "y" then
        return
      end
    end
  end

  if packer_exists then
    packer.sync(...)
  else
    error "Packer could not be loaded!"
  end
end

return M
