return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    cmd = 'Neotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    keys = {
      -- {
      --   '<leader>fe',
      --   function()
      --     require('neo-tree.command').execute { toggle = true, dir = Util.root() }
      --   end,
      --   desc = 'Explorer NeoTree (root dir)',
      -- },
      {
        '<leader>e',
        function()
          require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd() }
        end,
        desc = 'Explorer NeoTree (cwd)',
      },
      -- { '<leader>e', '<leader>e', desc = 'Explorer NeoTree (root dir)', remap = true },
      -- { '<leader>E', '<leader>E', desc = 'Explorer NeoTree (cwd)', remap = true },
      {
        '<leader>ge',
        function()
          require('neo-tree.command').execute { source = 'git_status', toggle = true }
        end,
        desc = 'Git explorer',
      },
      {
        '<leader>be',
        function()
          require('neo-tree.command').execute { source = 'buffers', toggle = true }
        end,
        desc = 'Buffer explorer',
      },
    },
    opts = {
      window = {
        position = 'right',
      },
    },
  },
  {
    'antosha417/nvim-lsp-file-operations',
    cmd = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim',
    },
  },
}
