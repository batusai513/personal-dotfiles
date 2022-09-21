vim.cmd "packadd packer.nvim"
-- Autocommand that reloads neovim whenever you save the plugins.init file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost neovim/.config/nvim/lua/plugins/init.lua source <afile> | PackerSync
  augroup end
]]

local plugins = {
  ["nvim-lua/plenary.nvim"] = { module = "plenary" },
  ["famiu/bufdelete.nvim"] = {
    cmd = { "Bdelete", "Bwipeout" },
  },
  ["wbthomason/packer.nvim"] = {
    cmd = require("core.lazy_load").packer_cmds,
    config = function()
      require "plugins"
    end,
  },

  ["nvim-lua/popup.nvim"] = {}, -- An implementation of the Popup API from vim in Neovim

  ["kyazdani42/nvim-web-devicons"] = {
    module = "nvim-web-devicons",
  },

  ["rafamadriz/friendly-snippets"] = {
    -- module = { "cmp", "cmp_nvim_lsp" },
    -- event = "InsertEnter",
  },

  ["L3MON4D3/LuaSnip"] = {
    -- after = "friendly-snippets",
  },
  --completions plugins
  ["hrsh7th/nvim-cmp"] = {
    -- after = "friendly-snippets",
    -- event = "InsertEnter",
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  ["saadparwaiz1/cmp_luasnip"] = {
    -- after = "nvim-cmp",
  },

  ["hrsh7th/cmp-nvim-lsp"] = {
    -- after = "nvim-cmp",
  },

  ["hrsh7th/cmp-buffer"] = {
    -- after = "nvim-cmp",
  },

  ["hrsh7th/cmp-cmdline"] = {
    -- after = "nvim-cmp",
  },

  ["hrsh7th/cmp-path"] = {
    -- after = "nvim-cmp",
  },
  --Language server protocol

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require("plugins.configs.lsp").setup()
    end,
    requires = {
      { "b0o/SchemaStore.nvim" },
      { "williamboman/nvim-lsp-installer" },
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "plugins.configs.lsp.null-ls"
        end,
        after = "nvim-lspconfig",
      },
      {
        "ray-x/lsp_signature.nvim",
      },
      {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
      },
    },
  },

  --language specific
  --rust
  ["simrat39/rust-tools.nvim"] = {
    requires = {
      { "mfussenegger/nvim-dap" },
    },
  },

  --lua
  ["folke/lua-dev.nvim"] = {},

  --typescript
  ["jose-elias-alvarez/typescript.nvim"] = {},

  --syntax highlighting
  ["nvim-treesitter/nvim-treesitter"] = {
    run = ":TSUpdate",
    module = "nvim-treesitter",
    cmd = require("core.lazy_load").treesitter_cmds,
    config = function()
      require "plugins.configs.treesitter"
    end,
  },

  ["p00f/nvim-ts-rainbow"] = {
    after = "nvim-treesitter",
  },

  ["JoosepAlviste/nvim-ts-context-commentstring"] = {
    after = "nvim-treesitter",
  },

  ["numToStr/Comment.nvim"] = {
    tag = "v0.6.1",
    after = "nvim-ts-context-commentstring",
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require "plugins.configs.comment"
    end,
  },

  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require "plugins.configs.todo-comments"
    end,
  },

  ["windwp/nvim-autopairs"] = {
    config = function()
      require "plugins.configs.autopairs"
    end,
    after = "nvim-cmp",
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    config = function()
      require "plugins.configs.indent-blankline"
    end,
  },

  --Github things
  ["lewis6991/gitsigns.nvim"] = {
    ft = "gitcommit",
    module = { "gitsigns" },
    requires = {
      "nvim-lua/plenary.nvim",
    },
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
    config = function()
      require("plugins.configs.gitsigns").setup()
    end,
    -- tag = 'release' -- To use the latest release
  },

  ["kdheepak/lazygit.nvim"] = {
    cmd = { "LazyGit", "LazyGitConfig" },
  },

  --buffer management
  ["akinsho/bufferline.nvim"] = {
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require "plugins.configs.bufferline"
    end,
  },

  --tree file viewer
  ["kyazdani42/nvim-tree.lua"] = {
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.configs.nvim-tree"
    end,
  },

  -- file navigation
  ["nvim-telescope/telescope.nvim"] = {
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
      },
    },
    wants = {
      "plenary.nvim",
      "popup.nvim",
      "telescope-fzf-native.nvim",
      "trouble.nvim",
      "nvim-tree.lua",
      "telescope-ui-select.nvim",
    },
    cmd = { "Telescope" },
    module = { "telescope", "telescope.builtin" },
    opt = true,
    config = function()
      require("plugins.configs.telescope").setup()
    end,
  },

  --find and replace
  ["windwp/nvim-spectre"] = {
    module = "spectre",
    config = function()
      require("plugins.configs.spectre").setup()
    end,
  },

  -- which-key
  ["folke/which-key.nvim"] = {
    after = "telescope.nvim",
    config = function()
      require("plugins.configs.which_key").init()
    end,
    event = "BufWinEnter",
  },

  --neovim optimisations
  ["lewis6991/impatient.nvim"] = {},

  ["SmiteshP/nvim-navic"] = {
    config = function()
      require("nvim-navic").setup {}
    end,
    module = { "nvim-navic" },
  },

  --terminal
  ["akinsho/toggleterm.nvim"] = {
    cmd = { "ToggleTerm", "TermExec" },
    module = { "toggleterm", "toggleterm.terminal" },
    keys = { [[<C-\>]] },
    config = function()
      require "plugins.configs.toggleterm"
    end,
  },

  --tmux
  ["aserowy/tmux.nvim"] = {
    config = function()
      require("plugins.configs.tmux").init()
    end,
  },

  --line
  ["nvim-lualine/lualine.nvim"] = {
    event = "BufReadPre",
    after = "nvim-treesitter",
    config = function()
      require("plugins.configs.lualine").setup()
    end,
  },

  --base colorscheme
  ["folke/tokyonight.nvim"] = {},

  --add/remove sorrunding charactes
  ["ur4ltz/surround.nvim"] = {
    config = function()
      require("surround").setup { mappings_style = "surround" }
    end,
  },
}

require("core.packer").run(plugins)
