local has_impatient, impatient = pcall(require, "impatient")
if has_impatient then
  impatient.enable_profile()
end

require "core"
require "core.options"
require "core.utils.prequire"
require "core.keymaps"

local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  defaults = {
    version = false,
  }
})

require "core.colorscheme"
pcall(require, "custom")
