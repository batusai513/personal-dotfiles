local icons = require "core.theme.icons"

local M = {}

function M.setup()
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },
    diagnostic = {

      -- show signs
      signs = {
        active = signs,
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = { icons.ui.Bug .. " Diagnostics:", "Normal" },
        prefix = "",
      },
      virtual_text = false,
    },
  }

  vim.diagnostic.config(config.diagnostic)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

return M
