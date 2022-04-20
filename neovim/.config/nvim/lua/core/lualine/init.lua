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
}
