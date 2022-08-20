vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)
require "core.utils.prequire"
require "core.options"
require "core.keymaps"
require "plugins"
require "core.colorscheme"
require "core.autocommands"
require "core.commands"
