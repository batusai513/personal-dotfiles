local lualine = prequire "lualine"

if not lualine then
  return
end

lualine.setup {
  options = {
    theme = "tokyonight",
    disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
  },
  extensions = {
    "nvim-tree",
    "toggleterm",
  },
}
