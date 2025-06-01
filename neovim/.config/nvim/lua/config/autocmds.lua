-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('_Internal_autocommands', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    ---@param keys string
    ---@param func function
    ---@param desc string
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local Util = require 'utils'

    local buffer = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- Diagnostic keymaps
    map('<leader>cd', vim.diagnostic.open_float, 'Show diagnostic error messages')
    map('[d', function()
      vim.diagnostic.jump { count = -1, float = true }
    end, 'Go to previous [D]iagnostic message')
    map(']d', function()
      vim.diagnostic.jump { count = 1, float = true }
    end, 'Go to next [D]iagnostic message')
    map('<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')

    if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
      map('<leader>uh', function()
        Util.toggle.inlay_hints()
      end, 'Toggle Inlay Hints')
    end
    if client then
      require('utils.lsp.attach_lsp_keymaps').attach_lsp_keymaps(client, buffer)
      require('utils.lsp.attach_lsp_capabilities').attach_lsp_capabilities(client, buffer, Util.lsp.options)
    end

    vim.diagnostic.config {
      virtual_text = false, -- or true, if you want inline diagnostics
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = 'rounded', -- <- this ensures jump float uses border
        source = 'if_many', -- optional, show diagnostic source
        header = '', -- optional
        prefix = '', -- optional
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
      },
    }
  end,
})
