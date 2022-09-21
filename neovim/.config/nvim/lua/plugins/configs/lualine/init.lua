local lualine = prequire "lualine"

if not lualine then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) < 420
end

local navic = require "nvim-navic"
local M = {}

function M.setup()
  lualine.setup {
    options = {
      theme = "auto",
      disabled_filetypes = { "dashboard", "NvimTree", "Outline", "toggleterm", "lazygit" },
      globalstatus = true,
    },
    extensions = {
      "nvim-tree",
      "toggleterm",
    },
    sections = {
      lualine_c = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
        {
          navic.get_location,
          cond = function()
            return navic.is_available and hide_in_width()
          end,
        },
      },
    },
  }
end
return M
