-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
vim.g.lazygit_config = false

opt.cmdheight = 0
opt.foldcolumn = "1"
opt.diffopt:append("linematch:60")
