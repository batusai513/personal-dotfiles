local Util = require 'custom.utils'
local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map('n', '<leader>uh', function()
    Util.toggle.inlay_hints()
  end, { desc = 'Toggle Inlay Hints' })
end

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- lazygit
map('n', '<leader>gg', function()
  Util.terminal({ 'lazygit' }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end, { desc = 'Lazygit (root dir)' })

map('n', '<leader>gG', function()
  Util.terminal({ 'lazygit' }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = 'Lazygit (cwd)' })

map('n', '<leader>gf', function()
  local git_path = vim.fn.system('git ls-files --full-name ' .. vim.api.nvim_buf_get_name(0))
  Util.terminal({ 'lazygit', '-f', vim.trim(git_path) }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = 'Lazygit current file history' })
