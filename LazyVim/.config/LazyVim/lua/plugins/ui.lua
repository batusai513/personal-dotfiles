return {
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = function(_, opts)
  --     vim.tbl_deep_extend("force", opts.extensions, { "toggleterm" })
  --     vim.tbl_deep_extend("force", opts.options.disabled_filetypes.statusline, { "neo-tree", "toggleterm" })
  --     opts.options.disabled_filetypes.winbar = { "dashboard", "alpha", "neo-tree", "toggleterm" }
  --     table.remove(opts.sections.lualine_c, 4)
  --     opts.winbar = {
  --       lualine_c = {
  --         {
  --           "filename",
  --         },
  --         {
  --           function()
  --             return require("nvim-navic").get_location()
  --           end,
  --           cond = function()
  --             return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
  --           end,
  --         },
  --       },
  --     }
  --     opts.inactive_winbar = {
  --       lualine_c = {
  --         "filename",
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "folke/noice.nvim",
  --   opts = {
  --     popupmenu = {
  --       backend = "nui",
  --     },
  --     presets = {
  --       lsp_doc_border = true,
  --     },
  --     ---@type NoiceConfigViews
  --     views = {
  --       hover = {
  --         border = {
  --           style = "single",
  --         },
  --         position = { row = 2, col = 2 },
  --       },
  --     },
  --     cmdline = {
  --       view = "cmdline",
  --       format = {
  --         search_down = {
  --           view = "cmdline",
  --         },
  --         search_up = {
  --           view = "cmdline",
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1500,
      fps = 60,
      top_down = false,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { [[<c-\>]], desc = "Toggle terminal" },
      { "<leader>\\h", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" },
      { "<leader>\\v", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" },
    },
    opts = {
      size = 10,
      open_mapping = [[<c-\>]],
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
    },
  },
}
