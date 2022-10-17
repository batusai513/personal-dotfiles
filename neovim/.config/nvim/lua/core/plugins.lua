local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- base plugins for things to work
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use {
    "lewis6991/impatient.nvim",
  }
  use { "kyazdani42/nvim-web-devicons" }

  --base colorscheme
  use "lunarvim/darkplus.nvim"
  use "rose-pine/neovim"
  use "folke/tokyonight.nvim"

  use {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  }
  use {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig" },
  }
  --completions plugins
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-path" }
  use { "hrsh7th/cmp-cmdline" }
  use { "saadparwaiz1/cmp_luasnip" }
  use { "L3MON4D3/LuaSnip" }
  use { "rafamadriz/friendly-snippets" }
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require "core.cmp"
    end,
  }
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }

  --Language server protocol
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "core.lsp"
    end,
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "core.lsp.null-ls"
    end,
  }
  use { "ray-x/lsp_signature.nvim" }
  use { "folke/trouble.nvim", cmd = "TroubleToggle" }
  use { "b0o/SchemaStore.nvim" }
  use { "simrat39/rust-tools.nvim" }
  use { "folke/neodev.nvim" }
  use { "jose-elias-alvarez/typescript.nvim" }

  --syntax highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "core.treesitter"
    end,
  }
  use "p00f/nvim-ts-rainbow"
  use {
    "windwp/nvim-autopairs",
    config = function()
      require "core.autopairs"
    end,
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "core.indent-blankline"
    end,
  }

  --comments
  use {
    "numToStr/Comment.nvim",
    config = function()
      require "core.comment"
    end,
  }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use {
    "folke/todo-comments.nvim",
    config = function()
      require "core.todo-comments"
    end,
  }

  --Github things
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require "core.gitsigns"
    end,
    -- tag = 'release' -- To use the latest release
  }

  --buffer management
  use {
    "akinsho/bufferline.nvim",
    config = function()
      require "core.bufferline"
    end,
  }

  --tree file viewer
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require "core.nvim-tree"
    end,
  }
  -- file navigation

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
      },
    },
    event = "BufWinEnter",
    config = function()
      require("core.telescope").init()
    end,
  }

  --find and replace
  use {
    "windwp/nvim-spectre",
    config = function()
      require("core.spectre").init()
    end,
  }

  -- which-key
  use {
    "folke/which-key.nvim",
    config = function()
      require("core.which_key").init()
    end,
    event = "BufWinEnter",
  }

  --terminal
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require "core.toggleterm"
    end,
  }

  --tmux
  use {
    "aserowy/tmux.nvim",
    config = function()
      require("core.tmux").init()
    end,
  }

  --line
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "core.lualine"
    end,
  }

  --add/remove sorrunding charactes
  use {
    "ur4ltz/surround.nvim",
    config = function()
      require("surround").setup { mappings_style = "surround" }
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
