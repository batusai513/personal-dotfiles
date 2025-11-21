return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      window = {
        position = "right",
      },
      filesystem = {
        filtered_items = {
          visible = false,
          hide_gitignored = true,
          hide_dotfiles = false,
        },
      },
    },
  },
  {
    "catppuccin",
    optional = true,
    opts = function()
      return {
        highlights = require("catppuccin.special.bufferline").get_theme(),
      }
    end,
  },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   opts = {
  --     defaults = {
  --       sorting_strategy = "ascending",
  --       layout_config = {
  --         horizontal = {
  --           prompt_position = "top",
  --           preview_width = 0.55,
  --         },
  --         vertical = {
  --           mirror = false,
  --         },
  --         width = 0.87,
  --         height = 0.80,
  --         preview_cutoff = 120,
  --       },
  --     },
  --   },
  -- },
}
