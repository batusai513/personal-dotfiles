return {
  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    opts = {
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        neotree = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      },
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
}
