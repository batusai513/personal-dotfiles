local icons = require "core.theme.icons"

local todoComments = prequire "todo-comments"
if not todoComments then
  return
end

local M = {}

function M.setup()
  local options = {
    keywords = {
      FIX = {
        icon = icons.debug, -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fix", "fixme", "bug" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = icons.ui.Check, color = "info" },
      HACK = { icon = icons.ui.Fire, color = "warning" },
      WARN = { icon = icons.diagnostics.Warning, color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = icons.misc.perf, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = icons.misc.note, color = "hint", alt = { "INFO" } },
    },
  }

  options = require("core.utils").load_override(options, "folke/todo-comments.nvim")
  todoComments.setup(options)
end

return M
