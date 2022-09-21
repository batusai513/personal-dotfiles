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
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
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
    spacing = 6, -- spacing between columns
    align = "center",
  },
  ignore_missing = true,
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
      w = { "<cmd>lua require 'telescope.builtin'.grep_string()<cr>", "Selected text" },
    },
  },
  mappings = {
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
    ["f"] = { "<cmd>Format<cr>", "Format" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Open explorer" },
    ["c"] = { "<cmd>Bdelete<cr>", "Close buffer" },
    ["C"] = { "<cmd>Bwipeout<cr>", "Close all buffers" },
    b = {
      name = "Buffers",
      j = { "<cmd>BufferLinePick<cr>", "Jump" },
      f = { "<cmd>lua require 'telescope.builtin'.buffers()<cr>", "Find buffer" },
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
    g = {
      name = "Git",
      j = { require("gitsigns").next_hunk, "Next Hunk" },
      k = { require("gitsigns").prev_hunk, "Prev Hunk" },
      l = { require("gitsigns").blame_line, "Blame" },
      p = { require("gitsigns").preview_hunk, "Preview Hunk" },
      r = { require("gitsigns").reset_hunk, "Reset Hunk" },
      R = { require("gitsigns").reset_buffer, "Reset Buffer" },
      s = { require("gitsigns").stage_hunk, "Stage Hunk" },
      u = {
        require("gitsigns").undo_stage_hunk,
        "Undo Stage Hunk",
      },
      o = { require("telescope.builtin").git_status, "Open changed file" },
      b = { require("telescope.builtin").git_branches, "Checkout branch" },
      c = { require("telescope.builtin").git_commits, "Checkout commit" },
      C = {
        require("telescope.builtin").git_bcommits,
        "Checkout commit(for current file)",
      },
      d = {
        function()
          require("gitsigns").diffthis "HEAD"
        end,
        "Git Diff",
      },
      g = { "<cmd>LazyGit <cr>", "LazyGit" },
    },
    l = {
      name = "LSP",
      a = { vim.lsp.buf.code_action, "Code Action" },
      d = {
        function()
          require("telescope.builtin").diagnostics { bufnr = 0, theme = "get_ivy" }
        end,
        "Buffer Diagnostics",
      },
      t = { "<cmd>Trouble document_diagnostics<cr>", "Document Troubles" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
      f = { "<cmd>Format<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
      j = {
        vim.diagnostic.goto_next,
        "Next Diagnostic",
      },
      k = {
        vim.diagnostic.goto_prev,
        "Prev Diagnostic",
      },
      l = { require("plugins.configs.lsp.utils").find_and_run_codelens, "CodeLens Action" },
      q = { vim.diagnostic.setloclist, "Quickfix" },
      r = { vim.lsp.buf.rename, "Rename" },
      s = { require("telescope.builtin").lsp_document_symbols, "Document Symbols" },
      e = { require("telescope.builtin").quickfix, "Telescope Quickfix" },
      S = {
        require("telescope.builtin").lsp_dynamic_workspace_symbols,
        "Workspace Symbols",
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
    r = {
      name = "Replace",
      r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
      w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
      f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
    },
    s = {
      name = "Search",
      f = { "<cmd>lua require'plugins.configs.telescope'.project_files()<cr>", "Find File" },
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
    t = {
      name = "+Trouble",
      r = { "<cmd>Trouble lsp_references<cr>", "References" },
      f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
      d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
      q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
      l = { "<cmd>Trouble loclist<cr>", "LocationList" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
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
