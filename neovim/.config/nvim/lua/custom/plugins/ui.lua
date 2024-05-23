local Util = require 'custom.utils'

return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
      { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
      { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
    },
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) Util.ui.bufremove(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) Util.ui.bufremove(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        -- diagnostics_indicator = function(_, _, diag)
        --   local icons = require("lazyvim.config").icons.diagnostics
        --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        --       .. (diag.warning and icons.Warn .. diag.warning or "")
        --   return vim.trim(ret)
        -- end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
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
