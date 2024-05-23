return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>\\"] = { name = "+terminal" },
        ["\\"] = {
          h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "ToggleTerm horizontal split" },
          v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "ToggleTerm vertical split" },
        },
      },
      mappings = {},
    },
  },
}
