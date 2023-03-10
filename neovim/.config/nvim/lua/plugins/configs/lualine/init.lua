local lualine = prequire "lualine"

if not lualine then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) < 420
end

local M = {}

function M.setup()
  lualine.setup {
    options = {
      theme = "auto",
      disabled_filetypes = { "dashboard", "NvimTree", "Outline", "toggleterm", "lazygit" },
      globalstatus = true,
    },
    extensions = {
      "neo-tree",
      "toggleterm",
    },
    sections = {
      lualine_c = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
    },
    winbar = {
      lualine_a = { 'filename' },
      lualine_c = {
        {
          function() return require("nvim-navic").get_location() end,
          cond = function()
            return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          end,
        }
      },
    },
    inactive_winbar = {
      lualine_c = { 'filename' },
    }
  }
end

return M
