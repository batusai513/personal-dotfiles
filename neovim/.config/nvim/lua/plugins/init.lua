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
  ["wbthomason/packer.nvim"] = {
    cmd = {
      "PackerSnapshot",
      "PackerSnapshotRollback",
      "PackerSnapshotDelete",
      "PackerInstall",
      "PackerUpdate",
      "PackerSync",
      "PackerClean",
      "PackerCompile",
      "PackerStatus",
      "PackerProfile",
      "PackerLoad",
    },
    config = function()
      require "plugins"
    end,
  },

  ["nvim-lua/popup.nvim"] = {}, -- An implementation of the Popup API from vim in Neovim

  ["rafamadriz/friendly-snippets"] = {
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  },

  --completions plugins
  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    event = "InsertEnter",
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
  },

  ["saadparwaiz1/cmp_luasnip"] = {
    after = "nvim-cmp",
  },

  ["hrsh7th/cmp-nvim-lsp"] = {
    after = "cmp_luasnip",
  },

  ["hrsh7th/cmp-buffer"] = {
    after = "cmp-nvim-lsp",
  },

  ["hrsh7th/cmp-cmdline"] = {
    after = "cmp-nvim-lsp",
  },

  ["hrsh7th/cmp-path"] = {
    after = "cmp-buffer",
  },
  --Language server protocol

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lsp"
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
  ["max397574/lua-dev.nvim"] = {},

  --typescript
  ["jose-elias-alvarez/typescript.nvim"] = {},

  --syntax highlighting
  ["nvim-treesitter/nvim-treesitter"] = {
    run = ":TSUpdate",
    module = "nvim-treesitter",
    cmd = {
      "TSInstall",
      "TSBufEnable",
      "TSBufDisable",
      "TSEnable",
      "TSDisable",
      "TSModuleInfo",
    },
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
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require "plugins.configs.gitsigns"
    end,
    -- tag = 'release' -- To use the latest release
  },

  --buffer management
  ["akinsho/bufferline.nvim"] = {
    config = function()
      require "plugins.configs.bufferline"
    end,
  },

  --tree file viewer
  ["kyazdani42/nvim-tree.lua"] = {
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
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
    event = "BufWinEnter",
    config = function()
      require("plugins.configs.telescope").init()
    end,
  },

  --find and replace
  ["windwp/nvim-spectre"] = {
    config = function()
      require("plugins.configs.spectre").init()
    end,
  },

  -- which-key
  ["folke/which-key.nvim"] = {
    config = function()
      require("plugins.configs.which_key").init()
    end,
    event = "BufWinEnter",
  },

  --neovim optimisations
  ["lewis6991/impatient.nvim"] = {},

  -- gps
  ["christianchiarulli/nvim-gps"] = {
    branch = "text_hl",
    config = function()
      require("plugins.configs.gps").init()
    end,
  },

  --terminal
  ["akinsho/toggleterm.nvim"] = {
    commit = "8e6f938ed8eec7f988dc07aec2af148ad57c6d95",
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
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require "plugins.configs.lualine"
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
