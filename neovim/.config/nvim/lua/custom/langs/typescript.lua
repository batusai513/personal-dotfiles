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
    opts = {},
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
