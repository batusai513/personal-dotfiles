vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)
require "core.colorscheme"
require "core"
require "core.options"

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }

  -- install plugins and complile configurations
  vim.cmd "packadd packer.nvim"
  require "plugins"
  vim.cmd "PackerSync"
end

require "core.utils.prequire"
require "core.keymaps"
