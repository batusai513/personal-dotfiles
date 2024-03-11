return { -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    keys = { ':', '/', '?' },
    version = false,
    dependencies = {
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      -- 'saadparwaiz1/cmp_luasnip',
      -- {
      --   'L3MON4D3/LuaSnip',
      --   build = (function()
      --     -- Build Step is needed for regex support in snippets
      --     -- This step is not supported in many windows environments
      --     -- Remove the below condition to re-enable on windows
      --     if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
      --       return
      --     end
      --     return 'make install_jsregexp'
      --   end)(),
      --   dependencies = {
      --     {
      --       'rafamadriz/friendly-snippets',
      --       config = function()
      --         require('luasnip.loaders.from_vscode').lazy_load()
      --       end,
      --     },
      --   },
      --   opts = {
      --     history = true,
      --     delete_check_events = 'TextChanged',
      --   },
      -- },
    },
    opts = function()
      local cmp = require 'cmp'
      -- local luasnip = require 'luasnip'
      local defaults = require 'cmp.config.default'()
      return {
        completion = {
          completeopt = 'menu,menuone,noselect',
        },
        sources = {
          { name = 'nvim_lsp' },
          -- { name = 'luasnip' },
          { name = 'path' },

          { name = 'buffer' },
        },
        sorting = defaults.sorting,

        -- snippet = {
        --   expand = function(args)
        --     vim.print(args)
        --     require('luasnip').lsp_expand(args.body)
        --   end,
        -- },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          ['<CR>'] = cmp.mapping.confirm { select = true },
          -- ['<C-l>'] = cmp.mapping(function()
          --   if luasnip.expand_or_locally_jumpable() then
          --     luasnip.expand_or_jump()
          --   end
          -- end, { 'i', 's' }),
          -- ['<C-h>'] = cmp.mapping(function()
          --   if luasnip.locally_jumpable(-1) then
          --     luasnip.jump(-1)
          --   end
          -- end, { 'i', 's' }),
        },
      }
    end,
    config = function(_, opts)
      -- for _, source in ipairs(opts.sources) do
      --   source.group_index = source.group_index or 1
      -- end

      -- See `:help cmp`
      local cmp = require 'cmp'
      cmp.setup(opts)

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    build = (function()
      -- Build Step is needed for regex support in snippets
      -- This step is not supported in many windows environments
      -- Remove the below condition to re-enable on windows
      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        return
      end
      return 'make install_jsregexp'
    end)(),
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
      {
        'hrsh7th/nvim-cmp',
        dependencies = {
          'saadparwaiz1/cmp_luasnip',
        },
        opts = function(_, opts)
          local cmp = require 'cmp'
          local luasnip = require 'luasnip'
          opts.snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          }

          table.insert(opts.sources, {
            name = 'luasnip',
          })

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          -- opts.mapping = cmp.mapping.preset.insert {
          --   ['<C-l>'] = cmp.mapping(function()
          --     if luasnip.expand_or_locally_jumpable() then
          --       luasnip.expand_or_jump()
          --     end
          --   end, { 'i', 's' }),
          --   ['<C-h>'] = cmp.mapping(function()
          --     if luasnip.locally_jumpable(-1) then
          --       luasnip.jump(-1)
          --     end
          --   end, { 'i', 's' }),
          -- }

          vim.tbl_deep_extend('force', opts.mapping, {

            ['<C-l>'] = cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { 'i', 's' }),
            ['<C-h>'] = cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { 'i', 's' }),
          })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
  },
}
