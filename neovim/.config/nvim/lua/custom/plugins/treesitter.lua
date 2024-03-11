return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = ':TSUpdate',
  event = { 'VeryLazy' },
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    -- Luckily, the only things that those plugins need are the custom queries, which we make available
    -- during startup.
    require('lazy.core.loader').add_to_rtp(plugin)
    require 'nvim-treesitter.query_predicates'
  end,
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'html',
      'lua',
      'markdown',
      'vim',
      'vimdoc',
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
  ---@param opts TSConfig
  config = function(_, opts)
    if type(opts.ensure_installed) == 'table' then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    require('nvim-treesitter.configs').setup(opts)
  end,

  -- config = function()
  --   -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  --
  --   ---@diagnostic disable-next-line: missing-fields
  --
  --   -- There are additional nvim-treesitter modules that you can use to interact
  --   -- with nvim-treesitter. You should go explore a few and see what interests you:
  --   --
  --   --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --   --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --   --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  -- end,
}
