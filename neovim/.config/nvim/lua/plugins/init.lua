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

  ["kyazdani42/nvim-web-devicons"] = {
    module = "nvim-web-devicons",
    event = "BufWinEnter",
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

  ["rafamadriz/friendly-snippets"] = {
    event = { "InsertEnter", "CmdlineEnter" },
  },

  ["L3MON4D3/LuaSnip"] = {
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  ["hrsh7th/nvim-cmp"] = {
    after = "LuaSnip",
    config = function()
      require("plugins.configs.cmp").setup()
    end,
  },

  ["hrsh7th/cmp-nvim-lsp"] = {},

  ["saadparwaiz1/cmp_luasnip"] = {
    after = "LuaSnip",
  },

  ["hrsh7th/cmp-buffer"] = {
    after = "nvim-cmp",
  },

  ["hrsh7th/cmp-cmdline"] = {
    after = "nvim-cmp",
  },

  ["hrsh7th/cmp-path"] = {
    after = "nvim-cmp",
  },

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
    event = "BufRead",
    cmd = require("core.lazy_load").treesitter_cmds,
    config = function()
      require("plugins.configs.treesitter").setup()
    end,
  },

  ["p00f/nvim-ts-rainbow"] = {
    after = "nvim-treesitter",
  },

  ["JoosepAlviste/nvim-ts-context-commentstring"] = {
    after = "nvim-treesitter",
  },

  ["numToStr/Comment.nvim"] = {
    after = "nvim-ts-context-commentstring",
    config = function()
      require("plugins.configs.comment").setup()
    end,
  },

  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    cmd = { "TodoQuickFix", "TodoLocList", "TodoTrouble", "TodoTelescope" },
    config = function()
      require("plugins.configs.todo-comments").setup()
    end,
  },

  ["windwp/nvim-autopairs"] = {
    config = function()
      require "plugins.configs.autopairs"
    end,
    after = "nvim-cmp",
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    event = "BufWinEnter",
    config = function()
      require "plugins.configs.indent-blankline"
    end,
  },

  ["dstein64/vim-startuptime"] = {
    cmd = "StartupTime",
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
    event = "UIEnter",
    requires = "nvim-web-devicons",
    config = function()
      require("plugins.configs.bufferline").setup()
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
    config = function()
      require("plugins.configs.which_key").init()
    end,
    module = "which-key",
    keys = { "<leader>", "`", "'" },
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
      require("plugins.configs.tmux").setup()
    end,
  },

  --line
  ["nvim-lualine/lualine.nvim"] = {
    event = "BufReadPre",
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

-- Run PackerCompile if there are changes in this file
-- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd(
  { "BufWritePost" },
  { pattern = "init.lua", command = "source <afile> | PackerSync", group = packer_grp }
)
