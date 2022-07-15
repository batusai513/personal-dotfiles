local toggleterm = prequire "toggleterm"
if not toggleterm then
  return
end

local config = {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 3,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
    execs = {
      { "lazygit", "<leader>gg", "LazyGit", "float" },
      { "lazygit", "<c-\\><c-g>", "LazyGit", "float" },
    },
  },
}

toggleterm.setup(config)

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

local terminal = prequire "toggleterm.terminal"
if not terminal then
  return
end
local Terminal = terminal.Terminal
local lazygit = Terminal:new { cmd = "lazygit", count = 101 }

function _Lazygit_toggle()
  lazygit:toggle()
end

local htop = Terminal:new { cmd = "htop", hidden = true, count = 102 }

function _Htop_toggle()
  htop:toggle()
end

local cargo_run = Terminal:new { cmd = "cargo run", hidden = true }

function _CARGO_RUN()
  cargo_run:toggle()
end

local cargo_test = Terminal:new { cmd = "cargo test", hidden = true }

function _CARGO_TEST()
  cargo_test:toggle()
end

local float_term = Terminal:new {
  direction = "float",
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n",
      "<m-1>",
      "<cmd>1ToggleTerm direction=float<cr>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "t",
      "<m-1>",
      "<cmd>1ToggleTerm direction=float<cr>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "i",
      "<m-1>",
      "<cmd>1ToggleTerm direction=float<cr>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-2>", "<nop>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-3>", "<nop>", { noremap = true, silent = true })
  end,
  count = 1,
}
