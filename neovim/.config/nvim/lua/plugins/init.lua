local fn = vim.fn

return {
  -- base plugins for things to work
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "lewis6991/impatient.nvim",
  "kyazdani42/nvim-web-devicons",

  --base colorscheme
  "lunarvim/darkplus.nvim",
  "rose-pine/neovim",
  "folke/tokyonight.nvim",
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig" },
  },
  --completions plugins
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "saadparwaiz1/cmp_luasnip",
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require "core.cmp"
    end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  --Language server protocol
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "core.lsp"
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "core.lsp.null-ls"
    end,
  },
  "ray-x/lsp_signature.nvim",
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  "b0o/SchemaStore.nvim",
  "simrat39/rust-tools.nvim",
  "folke/neodev.nvim",
  "jose-elias-alvarez/typescript.nvim",

  --syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "core.treesitter"
    end,
  },
  "p00f/nvim-ts-rainbow",
  {
    "windwp/nvim-autopairs",
    config = function()
      require "core.autopairs"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "core.indent-blankline"
    end,
  },

  --comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require "core.comment"
    end,
  },
  "JoosepAlviste/nvim-ts-context-commentstring",
  {
    "folke/todo-comments.nvim",
    config = function()
      require "core.todo-comments"
    end,
  },

  --Github things
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require "core.gitsigns"
    end,
    -- tag = 'release' -- To  the latest release
  },

  --buffer management
  {
    "akinsho/bufferline.nvim",
    config = function()
      require "core.bufferline"
    end,
  },

  --tree file viewer
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require "core.nvim-tree"
    end,
  },
  -- file navigation

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    event = "BufWinEnter",
    config = function()
      require("core.telescope").init()
    end,
  },

  --find and replace
  {
    "windwp/nvim-spectre",
    config = function()
      require("core.spectre").init()
    end,
  },

  -- which-key
  {
    "folke/which-key.nvim",
    config = function()
      require("core.which_key").init()
    end,
    event = "BufWinEnter",
  },

  --terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require "core.toggleterm"
    end,
  },

  --tmux
  {
    "aserowy/tmux.nvim",
    config = function()
      require("core.tmux").init()
    end,
  },

  --line
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "core.lualine"
    end,
  },

  --add/remove sorrunding charactes
  {
    "ur4ltz/surround.nvim",
    config = function()
      require("surround").setup { mappings_style = "surround" }
    end,
  },

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
}
