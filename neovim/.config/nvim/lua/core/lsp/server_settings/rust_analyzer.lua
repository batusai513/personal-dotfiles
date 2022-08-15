return function(server, opts)
  local server_default_props = server:get_default_options()

  local rustopts = {
    tools = {
      autoSetHints = true,
      inlay_hints = {
        -- prefix for parameter hints
        -- default: "<-"
        -- parameter_hints_prefix = "<- ",
        parameter_hints_prefix = " ",

        -- prefix for all the other hints (type, chaining)
        -- default: "=>"
        -- other_hints_prefix = "=> ",
        other_hints_prefix = " ",
      },
      hover_actions = {
        auto_focus = false,
        border = "rounded",
        width = 60,
      },
      on_initialized = function()
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
          pattern = { "*.rs" },
          callback = function()
            vim.lsp.codelens.refresh()
          end,
        })
      end,
    },
    server = vim.tbl_deep_extend("force", server_default_props, opts, {
      settings = {
        ["rust-analyzer"] = {
          lens = {
            enable = true,
          },
          checkOnSave = {
            command = "clippy",
          },
        },
      },
    }),
  }
  local ok, rust_tools = pcall(require, "rust-tools")
  if ok then
    rust_tools.setup(rustopts)
    server:attach_buffers()
  end
end
