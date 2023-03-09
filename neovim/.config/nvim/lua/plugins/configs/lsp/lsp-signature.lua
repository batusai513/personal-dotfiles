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

  require("core.utils").on_attach(function(_, buffer)
    signature.on_attach(options, buffer)
  end)
end

return M
