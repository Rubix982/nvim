-- Enhanced project-wide search (GoLand-like Find in Files)
return {
  -- Spectre: project-wide find & replace panel
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>S', function() require('spectre').toggle() end, desc = 'Find & Replace (Spectre)' },
      { '<leader>sW', function() require('spectre').open_visual { select_word = true } end, desc = 'Search current word (Spectre)' },
      { '<leader>sW', function() require('spectre').open_visual() end, mode = 'v', desc = 'Search selection (Spectre)' },
      { '<leader>sP', function() require('spectre').open_file_search { select_word = true } end, desc = 'Search in current file (Spectre)' },
    },
    opts = {
      open_cmd = 'noswapfile vnew',
      live_update = true,
      is_block_ui_break = true,
      highlight = {
        search = 'DiffDelete',
        replace = 'DiffAdd',
      },
    },
  },

  -- Trouble: better quickfix list for browsing all search results
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'Trouble', 'TroubleToggle' },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<CR>', desc = 'Quickfix list (Trouble)' },
      { '<leader>xl', '<cmd>Trouble loclist toggle<CR>', desc = 'Location list (Trouble)' },
    },
    opts = {
      position = 'bottom',
      height = 15,
      use_diagnostic_signs = true,
    },
  },
}
