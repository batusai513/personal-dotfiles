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
}

-- Install your plugins here
return packer.startup(function(use)
  -- base plugins for things to work
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  --UI
  use({
    'CosmicNvim/cosmic-ui',
    requires = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      require('cosmic-ui').setup()
    end,
  })

  --completions plugins
  use "hrsh7th/nvim-cmp" -- base plugin
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use "saadparwaiz1/cmp_luasnip"

  --snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  --Language server protocol
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  --syntax highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use "p00f/nvim-ts-rainbow"


  use "windwp/nvim-autopairs"

  --comments
  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  -- tag = 'release' -- To use the latest release
  }

  --buffer management
  use "akinsho/bufferline.nvim"

  --tree file viewer
  use 'kyazdani42/nvim-tree.lua'
  -- file navigation

  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
      },
    },
    config = function()
      require('core.telescope').init()
      -- require('core.telescope')
    end,
    event = 'BufWinEnter',
    -- disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'telescope'),
  })

  --neovim optimisations
  use 'lewis6991/impatient.nvim'

  --terminal
  use "akinsho/toggleterm.nvim"
  --tmux
  use ({
    "aserowy/tmux.nvim",
    config = function ()
      require"core.tmux".init()
    end
  })

  --base colorscheme
  use 'folke/tokyonight.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
