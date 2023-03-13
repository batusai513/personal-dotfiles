local M = {}

local config = {
  plugins = {
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  window = {
    border = "single", -- none, single, double, shadow
  },
  layout = {
    spacing = 4, -- spacing between columns
    align = "center",
  },
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
  vmappings = {
    f = {
      name = "Find selected",
      w = { "<cmd>lua require 'telescope.builtin'.grep_string()<cr>", "Selected text" },
    },
  },
  mappings = {
    w = { "<cmd>w!<CR>", "Save" },
    q = { "<cmd>q!<CR>", "Quit" },
    f = { "<cmd>Format<cr>", "Format" },
    t = { name = "+tabs" },
    b = { name = "+buffer" },
    g = { name = "+git" },
    l = {
      name = "LSP",
      a = { vim.lsp.buf.code_action, "Code Action" },
      d = {
        function()
          require("telescope.builtin").diagnostics { bufnr = 0, theme = "get_ivy" }
        end,
        "Buffer Diagnostics",
      },
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
    r = {
      name = "Replace",
      r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
      w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
      f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
    },
    s = {
      name = "Search",
      f = { require("plugins.configs.telescope").project_files, "Find File" },
      h = { require("telescope.builtin").help_tags, "Find Help" },
      M = { require("telescope.builtin").man_pages, "Man Pages" },
      r = { require("telescope.builtin").oldfiles, "Open Recent File" },
      R = { require("telescope.builtin").registers, "Registers" },
      t = { require("telescope.builtin").live_grep, "Text" },
      k = { require("telescope.builtin").keymaps, "Keymaps" },
      C = { require("telescope.builtin").commands, "Commands" },
      b = { require("telescope.builtin").buffers, "Find buffer" },
      c = {
        function()
          require("telescope.builtin.internal").colorscheme { enable_preview = true }
        end,
        "Colorscheme with Preview",
      },
      --Git
      o = { require("telescope.builtin").git_status, "Open changed file" },
      ["gb"] = { require("telescope.builtin").git_branches, "Checkout branch" },
      ["gc"] = { require("telescope.builtin").git_commits, "Checkout commit" },
      ["gC"] = {
        require("telescope.builtin").git_bcommits,
        "Checkout commit(for current file)",
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
