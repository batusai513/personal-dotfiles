local M = {}

local config = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim

    -- No actual key bindings are created
    presets = {

      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator

      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
    spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  vmappings = {
    ["/"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
    f = {
      name = "Find selected",
      w = { "<cmd>Telescope grep_string<cr>", "Selected text" },
    },
  },
  mappings = {
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
    ["f"] = { "<cmd>Format<cr>", "Format" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Open explorer" },
    ["c"] = { "<cmd>BufferKill<cr>", "Close buffer" },
    b = {
      name = "Buffers",
      j = { "<cmd>BufferLinePick<cr>", "Jump" },
      f = { "<cmd>Telescope buffers<cr>", "Find" },
      b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
      c = { "<cmd>BufferKill<cr>", "Close buffer" },
      e = {
        "<cmd>BufferLinePickClose<cr>",
        "Pick which buffer to close",
      },

      h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
      l = {
        "<cmd>BufferLineCloseRight<cr>",
        "Close all to the right",
      },
      D = {
        "<cmd>BufferLineSortByDirectory<cr>",

        "Sort by directory",
      },
      L = {
        "<cmd>BufferLineSortByExtension<cr>",
        "Sort by language",
      },
    },
    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    g = {
      name = "Git",
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
      },
      o = { "<cmd>lua require'telescope.builtin'.git_status()<cr>", "Open changed file" },
      b = { "<cmd>lua require'telescope.builtin'.git_branches()<cr>", "Checkout branch" },
      c = { "<cmd>lua require'telescope.builtin'.git_commits()<cr>", "Checkout commit" },
      C = {
        "<cmd>lua require'telescope.builtin'.git_bcommits()<cr>",
        "Checkout commit(for current file)",
      },
      d = {
        "<cmd>Gitsigns diffthis HEAD<cr>",
        "Git Diff",
      },
      g = { "<cmd>lua _Lazygit_toggle()<cr>", "LazyGit" },
    },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = { "<cmd>lua require'telescope.builtin'.diagnostics({bufnr=0, theme='get_ivy'})<cr>", "Buffer Diagnostics" },
      t = { "<cmd>Trouble document_diagnostics<cr>", "Document Troubles" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
      f = { "<cmd>Format<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
      j = {
        "<cmd>lua vim.diagnostic.goto_next()<cr>",
        "Next Diagnostic",
      },
      k = {
        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        "Prev Diagnostic",
      },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<cr>", "Document Symbols" },
      e = { "<cmd>lua require'telescope.builtin'.quickfix()<cr>", "Telescope Quickfix" },
      S = {
        "<cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols()<cr>",
        "Workspace Symbols",
      },
      p = {
        name = "Peek",
        d = { "<cmd>lua require'core.lsp.peek'.Peek('definition')<cr>", "Definition" },
        t = { "<cmd>lua require'core.lsp.peek'.Peek('typeDefinition')<cr>", "Type Definition" },
        i = { "<cmd>lua require'core.lsp.peek'.Peek('implementation')<cr>", "Implementation" },
      },
    },
    s = {
      name = "Search",
      f = { "<cmd>lua require'core.telescope'.project_files()<cr>", "Find File" },
      h = { "<cmd>lua require'telescope.builtin'.help_tags()<cr>", "Find Help" },
      M = { "<cmd>lua require'telescope.builtin'.man_pages()<cr>", "Man Pages" },
      r = { "<cmd>lua require'telescope.builtin'.oldfiles()<cr>", "Open Recent File" },
      R = { "<cmd>lua require'telescope.builtin'.registers()<cr>", "Registers" },
      t = { "<cmd>lua require'telescope.builtin'.live_grep()<cr>", "Text" },
      k = { "<cmd>lua require'telescope.builtin'.keymaps()<cr>", "Keymaps" },
      C = { "<cmd>lua require'telescope.builtin'.commands()<cr>", "Commands" },
      c = {
        "<cmd>lua require'telescope.builtin.internal'.colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
    },
    ["\\"] = {
      name = "Terminal",
      ["1"] = { ":1ToggleTerm<cr>", "1" },
      ["2"] = { ":2ToggleTerm<cr>", "2" },
      ["3"] = { ":3ToggleTerm<cr>", "3" },
      ["4"] = { ":4ToggleTerm<cr>", "4" },
      h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
      v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
      m = { "<cmd>lua _Htop_toggle()<cr>", "HTOP" },
    },
    t = {
      name = "+Trouble",
      r = { "<cmd>Trouble lsp_references<cr>", "References" },
      f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
      d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
      q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
      l = { "<cmd>Trouble loclist<cr>", "LocationList" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
    },
  },
}

function M.init()
  local which_key = require "which-key"
  which_key.setup(config)

  local opts = config.opts
  local vopts = config.vopts

  local mappings = config.mappings
  local vmappings = config.vmappings

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end

return M
