return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'ron', 'rust', 'toml' })
      end
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    ft = { 'rust' },
  },
}
