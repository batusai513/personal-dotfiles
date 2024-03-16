return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'typescript', 'javascript', 'jsdoc', 'tsx' })
      end
    end,
  },
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      defaults = {
        ['<leader>ct'] = { name = '+Typescript refactors', _ = 'which_key_ignore' },
      },
    },
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    ft = {
      'typescript',
      'typescriptreact',
      'javascript',
      'javascriptreact',
    },
    opts = {
      on_attach = function(_, buffer)
        local set = vim.keymap.set

        set('n', '<leader>cto', '<cmd>TSToolsSortImports<cr>', { desc = 'Sort file imports', buffer = buffer })
        set('n', '<leader>ctR', '<cmd>TSToolsRemoveUnusedImports<cr>', { desc = 'Remove unused imports', buffer = buffer })
        set('n', '<leader>ctr', '<cmd>TSToolsRemoveUnused<cr>', { desc = 'Remove all unused statements', buffer = buffer })
        set('n', '<leader>ctF', '<cmd>TSToolsFixAll<cr>', { desc = 'Fix all fixable errors', buffer = buffer })
        set('n', '<leader>ctM', '<cmd>TSToolsAddMissingImports<cr>', { desc = 'Add all missing imports', buffer = buffer })
      end,
      settings = {
        expose_as_code_action = 'all',
        code_lens = 'all',
        tsserver_file_preferences = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = false,
        },
      },
    },
    keys = {},
  },
  {
    'neovim/nvim-lspconfig',
    -- other settings removed for brevity
    opts = {
      ---@type lspconfig.options
      servers = {
        eslint = {
          keys = {
            {
              '<leader>cL',
              function()
                vim.cmd 'EslintFixAll'
              end,
              desc = 'Eslint Fix All',
              mode = { 'n' },
            },
          },
          settings = {
            format = false,
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = {
              mode = 'auto',
            },
          },
        },
      },
    },
  },
}
