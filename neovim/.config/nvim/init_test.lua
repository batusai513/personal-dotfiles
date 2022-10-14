-- this template is borrowed from nvim-lspconfig
local on_windows = vim.loop.os_uname().version:match "Windows"

local function join_paths(...)
  local path_sep = on_windows and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

vim.g.loaded_remote_plugins = ""
vim.cmd [[set runtimepath=$VIMRUNTIME]]

local temp_dir = vim.loop.os_getenv "TEMP" or "/tmp"

vim.cmd("set packpath=" .. join_paths(temp_dir, "nvim", "site"))

local package_root = join_paths(temp_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

local null_ls_config = function()
  local null_ls = require "null-ls"
  local formatting = null_ls.builtins.formatting
  -- add only what you need to reproduce your issue
  null_ls.setup {
    sources = {
      formatting.prettier.with {
        only_local = "node_modules/.bin",
      },
    },
    debug = true,
  }
end

local function load_plugins()
  -- only add other plugins if they are necessary to reproduce the issue
  require("packer").startup {
    {
      "wbthomason/packer.nvim",
      {
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = null_ls_config,
      },
    },
    config = {
      package_root = package_root,
      compile_path = compile_path,
      profile = {
        enable = true,
        threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
      },
    },
  }
end

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
  load_plugins()
  require("packer").sync()
else
  load_plugins()
  require("packer").sync()
end
