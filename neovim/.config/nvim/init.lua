vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)
require "core.colorscheme"
require "core"
require "core.options"
require "core.utils.prequire"
require "core.keymaps"
require "plugins"
