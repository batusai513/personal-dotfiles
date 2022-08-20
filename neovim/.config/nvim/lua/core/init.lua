local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local api = vim.api

vim.cmd [[
  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]

vim.cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi NormalNC ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi MsgArea ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi EndOfBuffer ctermbg=none guibg=none"
vim.cmd "let &fcs='eob: '"
vim.cmd [[ command! BufferKill lua require('plugins.configs.bufferline').buf_kill('bd') ]]

autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Highlight on yank
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "Search" }
  end,
  group = highlight_group,
  pattern = "*",
})

autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})
