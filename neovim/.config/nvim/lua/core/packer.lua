local M = {}

M.options = {
  git = {
    clone_timeout = 6000,
  },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

M.run = function(plugins)
  local present, packer = pcall(require, "packer")
  if not present then
    return
  end

  plugins = require("core.utils").merge_plugins(plugins)

  packer.init(M.options)

  packer.startup(function(use)
    for _, value in pairs(plugins) do
      use(value)
    end
  end)
end

return M
