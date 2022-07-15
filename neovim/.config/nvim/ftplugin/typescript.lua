
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  L = {
    name = "Typescript",
    m = { "<cmd>lua require 'typescript'.actions.addMissingImports()<Cr>", "Add missing imports" },
    o = { "<cmd>lua require 'typescript'.actions.organizeImports()<Cr>", "Organize imports" },
    r = { "<cmd>lua require 'typescript'.actions.removeUnused()<Cr>", "Remove unused" },
    f = { "<cmd>lua require 'typescript'.actions.fixAll()<Cr>", "Fix all (than can be fixable)" },
  },
}

which_key.register(mappings, opts)
