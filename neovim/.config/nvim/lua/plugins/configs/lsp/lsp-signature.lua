local M = {}

function M.setup()
  local signature = prequire "lsp_signature"
  if not signature then
    return
  end

  local options = {
    bind = true,
    floating_window = false,
    hint_prefix = "",
    hint_scheme = "Comment",
  }

  options = require("core.utils").load_override(options, "ray-x/lsp_signature.nvim")

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      signature.on_attach(options, args.buf)
    end,
  })
end

return M
