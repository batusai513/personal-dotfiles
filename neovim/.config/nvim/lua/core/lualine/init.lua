local lualine = prequire "lualine"

if not lualine then
  return
end

lualine.setup {
  options = {
    theme = "tokyonight",
    disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
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
    },
  },
}
