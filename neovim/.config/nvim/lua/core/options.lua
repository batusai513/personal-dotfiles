local opt = vim.opt
local g = vim.g

-- :help options

opt.laststatus = 3
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore

opt.title = true
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

--indenting
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.smartindent = true -- make indenting smarter again
opt.softtabstop = 2
opt.tabstop = 2 -- insert 2 spaces for a tab

opt.fillchars = { eob = " " }
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- smart case
opt.mouse = "a" -- allow the mouse to be used in neovim

opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.numberwidth = 2 -- set number column width to 2 {default 4}
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 250 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- enable persistent undo

opt.updatetime = 300 -- faster completion (4000ms default)

opt.whichwrap:append "<>[]hl"
opt.shortmess:append "c"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.backup = false -- creates a backup file
opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.pumheight = 10 -- pop up menu height
opt.showtabline = 2 -- always show tabs
opt.swapfile = false -- creates a swapfile
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.cursorline = true -- highlight the current line

opt.wrap = false -- display lines as one long line
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.guifont = "JetBrainsMono Nerd Font:h15" -- the font used in graphical neovim applications

vim.cmd [[set iskeyword+=-]]

-- disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
