local comment = prequire "Comment"
if not comment then
  return
end

local M = {}

function M.setup()
  local options = {
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  }

  options = require("core.utils").load_override(options, "numToStr/Comment.nvim")

  comment.setup(options)
end

return M
