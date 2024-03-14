return {
  {
    'nvim-telescope/telescope.nvim',
    version = false,
    cmd = 'Telescope',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    keys = {
      -- stylua: ignore start
      { '<leader>sh',       function() require('telescope.builtin').help_tags() end,   desc = '[S]earch [H]elp' },
      { '<leader>sk',       function() require('telescope.builtin').keymaps() end,     desc = '[S]earch [K]eymaps' },
      { '<leader>sf',       function() require('telescope.builtin').find_files() end,  desc = '[S]earch [F]iles' },
      { '<leader>ss',       function() require('telescope.builtin').builtin() end,     desc = '[S]earch [S]elect Telescope' },
      { '<leader>sw',       function() require('telescope.builtin').grep_string() end, desc = '[S]earch current [W]ord' },
      { '<leader>sg',       function() require('telescope.builtin').live_grep() end,   desc = '[S]earch by [G]rep' },
      { '<leader>sd',       function() require('telescope.builtin').diagnostics() end, desc = '[S]earch [D]iagnostics' },
      { '<leader>sr',       function() require('telescope.builtin').resume() end,      desc = '[S]earch [R]esume' },
      { '<leader>s.',       function() require('telescope.builtin').oldfiles() end,    desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader><leader>', function() require('telescope.builtin').buffers() end,     desc = '[ ] Find existing buffers' },
      {
        '<leader>/',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())
        end,
        desc = '[/] Fuzzily search in current buffer'
      },
      { '<leader>s/', function() require('telescope.builtin').live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files', } end, desc = '[S]earch [/] in Open Files' },
      { '<leader>sn', function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } end,                                    desc = '[S]earch [N]eovim files' },
      -- stylua: ignore end
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
  }
}
