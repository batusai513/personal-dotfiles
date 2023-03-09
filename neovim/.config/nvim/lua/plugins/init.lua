local plugins = {
  ["nvim-lua/plenary.nvim"] = { lazy = true },
  ["famiu/bufdelete.nvim"] = {
    cmd = { "Bdelete", "Bwipeout" },
  },
  ["kyazdani42/nvim-web-devicons"] = {
    module = "nvim-web-devicons",
    lazy = true
  },
  --Language server protocol

  ["neovim/nvim-lspconfig"] = {
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.configs.lsp").setup()
    end,
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      {
        "folke/neodev.nvim",
        opts = { experimental = { pathStrict = true } }
      },
      {
        "jose-elias-alvarez/typescript.nvim"
      },
      {
        "b0o/SchemaStore.nvim",
        module = { "schemastore" },
        version = false,
      },
      {
        "williamboman/mason-lspconfig.nvim",
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("core.utils").has("nvim-cmp")
        end,
      },
      {
        "ray-x/lsp_signature.nvim",
        module = "lsp_signature",
        event = { "InsertEnter" },
        config = function()
          require("plugins.configs.lsp.lsp-signature").setup()
        end,
      },
      {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
          { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
          { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
          { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
          { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
          {
            "[q",
            function()
              if require("trouble").is_open() then
                require("trouble").previous({ skip_groups = true, jump = true })
              else
                vim.cmd.cprev()
              end
            end,
            desc = "Previous trouble/quickfix item",
          },
          {
            "]q",
            function()
              if require("trouble").is_open() then
                require("trouble").next({ skip_groups = true, jump = true })
              else
                vim.cmd.cnext()
              end
            end,
            desc = "Next trouble/quickfix item",
          },
        },
      },
    },
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    config = function()
      require "plugins.configs.lsp.null-ls"
    end,
  },
  ["williamboman/mason.nvim"] = {
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "flake8",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
  ["SmiteshP/nvim-navic"] = {
    config = function()
      require("plugins.configs.lsp.navic").setup()
    end,
    module = { "nvim-navic" },
    event = { "BufWinEnter" },
  },
  ["L3MON4D3/LuaSnip"] = {
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  ["hrsh7th/nvim-cmp"] = {
    version = false,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      require("plugins.configs.cmp").setup()
    end,
  },
  --rust
  ["simrat39/rust-tools.nvim"] = {
    dependencies = {
      { "mfussenegger/nvim-dap" },
    },
  },
  --syntax highlighting
  ["nvim-treesitter/nvim-treesitter"] = {
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = require("core.lazy_load").treesitter_cmds,
    dependencies = {
      "p00f/nvim-ts-rainbow",
    },
    config = function()
      require("plugins.configs.treesitter").setup()
    end,
  },
  ["JoosepAlviste/nvim-ts-context-commentstring"] = { lazy = true },
  ["echasnovski/mini.comment"] = {
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring {}
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  ["folke/todo-comments.nvim"] = {
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins.configs.todo-comments").setup()
    end,
  },
  ["windwp/nvim-autopairs"] = {
    event = "InsertEnter",
    config = function()
      require("plugins.configs.autopairs").setup()
    end,
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
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.configs.gitsigns").setup()
    end,
  },
  ["kdheepak/lazygit.nvim"] = {
    cmd = { "LazyGit", "LazyGitConfig" },
  },
  --buffer management
  ["akinsho/bufferline.nvim"] = {
    event = "VeryLazy",
    dependencies = "nvim-web-devicons",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diagnostics)
          local result = {}
          local symbols = { error = "", warning = "", info = "" }
          for name, count in pairs(diagnostics) do
            if symbols[name] and count > 0 then
              table.insert(result, symbols[name] .. count)
            end
          end
          result = table.concat(result, " ")
          return #result > 0 and result or ""
        end,
        offsets = {
          {
            filetype = "undotree",
            text = "Undotree",
            highlight = "PanelHeading",
            padding = 1,
          },
          {
            filetype = "NvimTree",
            text = "Explorer",
            highlight = "PanelHeading",
            padding = 1,
          },
          {
            filetype = "DiffviewFiles",
            text = "Diff View",
            highlight = "PanelHeading",
            padding = 1,
          },
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
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
    dependencies = {
      "plenary.nvim",
      "popup.nvim",
      "telescope-fzf-native.nvim",
      "trouble.nvim",
      "nvim-tree.lua",
      "telescope-ui-select.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = { "Telescope" },
    module = { "telescope", "telescope.builtin" },
    lazy = true,
    config = function()
      require("plugins.configs.telescope").setup()
    end,
  },
  --find and replace
  ["windwp/nvim-spectre"] = {
    module = "spectre",
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  -- which-key
  ["folke/which-key.nvim"] = {
    event = "VeryLazy",
    keys = { "<leader>", "`", "'", desc = "which key" },
    config = function()
      require("plugins.configs.which_key").init()
    end,
  },
  --neovim optimisations
  ["lewis6991/impatient.nvim"] = {},
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
    event = "VeryLazy",
  },
  --line
  ["nvim-lualine/lualine.nvim"] = {
    event = "VeryLazy",
    dependencies = {
      "SmiteshP/nvim-navic"
    },
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

return require("core.packer").run(plugins)
