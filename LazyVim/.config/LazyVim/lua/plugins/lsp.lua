return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
      servers = {
        eslint = {
          -- ESLint 10 removed 'eslint/use-at-your-own-risk'. When before_init
          -- detects a flat config file and sets useFlatConfig=true, the LSP
          -- server tries to require('eslint/use-at-your-own-risk') which fails
          -- with MODULE_NOT_FOUND, silently disabling linting. With ESLint 10,
          -- loading from 'eslint' directly handles flat config automatically.
          before_init = function(_, config)
            config.settings = config.settings or {}
            config.settings.experimental = { useFlatConfig = false }
            local root_dir = config.root_dir
            if root_dir then
              config.settings.workspaceFolder = {
                uri = root_dir,
                name = vim.fn.fnamemodify(root_dir, ":t"),
              }
            end
          end,
        },
      },
    },
  },
}
