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

-- merge default/user plugin tables
M.merge_plugins = function(default_plugins)
  local user_plugins = {}

  -- merge default + user plugin table
  default_plugins = merge_tb("force", default_plugins, user_plugins)

  local final_table = {}

  for key, _ in pairs(default_plugins) do
    default_plugins[key][1] = key
    final_table[#final_table + 1] = default_plugins[key]
  end

  return final_table
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
          " on a NvChadSnapshot. This will cause issues if NvChad dependencies contain "
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
