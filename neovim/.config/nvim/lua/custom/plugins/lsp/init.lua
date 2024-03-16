return {
  { 'j-hui/fidget.nvim', event = 'LspAttach', dependencies = { 'neovim/nvim-lspconfig' }, opts = {} },
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      {
        'folke/neoconf.nvim',
        cmd = 'Neoconf',
        config = false,
        dependencies = { 'nvim-lspconfig' },
      },
      {
        'folke/neodev.nvim',
        opts = {},
      },
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'j-hui/fidget.nvim',
    },
    opts = {
      lsp_handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', silent = true }),
        ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded', silent = true }),
      },
      -- options for vim.diagnostic.config()
      diagnostics = {
        update_in_insert = true,
        underline = true,
        float = {
          focused = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
        -- virtual_text = {
        --   spacing = 4,
        --   source = 'if_many',
        --   prefix = '●',
        --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        --   -- prefix = "icons",
        -- },
        virtual_text = false,
        severity_sort = true,
        -- signs = {
        --   text = {
        --     [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Error,
        --     [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
        --     [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
        --     [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
        --   },
        -- },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      ----@type lspconfig.options
      servers = {
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local Utils = require 'custom.utils'

      Utils.lsp.on_attach(function(client, buffer)
        vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = buffer })
        require('custom.plugins.lsp.keymaps').on_attach(client, buffer)
        require('custom.plugins.lsp.on_attach').on_attach(client, buffer, opts)
      end)

      for method, handler in pairs(opts.lsp_handlers or {}) do
        if handler then
          vim.lsp.handlers[method] = handler
        end
      end

      local register_capability = vim.lsp.handlers['client/registerCapability']

      vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require('custom.plugins.lsp.keymaps').on_attach(client, buffer)
        require('custom.plugins.lsp.on_attach').on_attach(client, buffer, opts)
        return ret
      end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
        opts.diagnostics.virtual_text.prefix = vim.fn.has 'nvim-0.10.0' == 0 and '●'
        -- or function(diagnostic)
        --   local icons = require("lazyvim.config").icons.diagnostics
        --   for d, icon in pairs(icons) do
        --     if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
        --       return icon
        --     end
        --   end
        -- end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {}

      if type(opts.servers) == 'table' then
        servers = vim.tbl_deep_extend('force', {}, servers, opts.servers)
      end

      require('neoconf').setup()

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server_opts = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
            require('lspconfig')[server_name].setup(server_opts)
          end,
        },
      }
    end,
  },
}
