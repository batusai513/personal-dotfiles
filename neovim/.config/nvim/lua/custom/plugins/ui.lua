local Util = require 'custom.utils'

return {
  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss all Notifications',
      },
    },
    opts = {
      fps = 60,
      top_down = false,
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      Util.on_very_lazy(function()
        vim.notify = require 'notify'
      end)
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
    main = 'ibl',
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = function()
      local logo = [[
██╗░░░██╗███╗░░░███╗  ░█████╗░░█████╗░██████╗░███████╗
██║░░░██║████╗░████║  ██╔══██╗██╔══██╗██╔══██╗██╔════╝
╚██╗░██╔╝██╔████╔██║  ██║░░╚═╝██║░░██║██║░░██║█████╗░░
░╚████╔╝░██║╚██╔╝██║  ██║░░██╗██║░░██║██║░░██║██╔══╝░░
░░╚██╔╝░░██║░╚═╝░██║  ╚█████╔╝╚█████╔╝██████╔╝███████╗
░░░╚═╝░░░╚═╝░░░░░╚═╝  ░╚════╝░░╚════╝░╚═════╝░╚══════╝
      ]]

      logo = string.rep('\n', 8) .. logo .. '\n\n'
      local opts = {
        theme = 'doom',
        config = {
          header = vim.split(logo, '\n'),
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'DashboardLoaded',
          callback = function()
            require('lazy').show()
          end,
        })
      end
      return opts
    end,
  },
}
