return {
  "hrsh7th/nvim-cmp",
  commit = false,
  keys = { ":", "/", "?" },
  dependencies = {
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-cmdline",
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    return require("astronvim.utils").extend_tbl(opts, {
      sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "emoji",    priority = 700 },
        { name = "calc",     priority = 650 },
        { name = "path",     priority = 500 },
        { name = "buffer",   priority = 250 },
      },
    })
  end,
  config = function(_, opts)
    local cmp = require "cmp"
    -- run cmp setup
    cmp.setup(opts)

    -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,
}
