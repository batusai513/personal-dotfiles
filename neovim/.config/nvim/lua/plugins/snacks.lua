-- Terminal Mappings
local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and '<c-' .. dir .. '>' or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = {
      win = {
        keys = {
          nav_h = { '<C-h>', term_nav 'h', desc = 'Go to Left Window', expr = true, mode = 't' },
          nav_j = { '<C-j>', term_nav 'j', desc = 'Go to Lower Window', expr = true, mode = 't' },
          nav_k = { '<C-k>', term_nav 'k', desc = 'Go to Upper Window', expr = true, mode = 't' },
          nav_l = { '<C-l>', term_nav 'l', desc = 'Go to Right Window', expr = true, mode = 't' },
        },
      },
    },
  },
  keys = {
		--stylua: ignore start
		{ '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
		{ '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },

		{ '<C-/>', function () Snacks.terminal() end, desc = 'Terminal' },
		{ '<C-/>', '<cmd>close<cr>', desc = 'Close Terminal', mode = 't' },

		{ '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    --stylua: ignore end
  },
}
