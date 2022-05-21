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

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "Search" }
  end,
  group = highlight_group,
  pattern = "*",
})
