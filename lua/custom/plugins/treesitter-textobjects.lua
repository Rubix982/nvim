return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'VeryLazy',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      textobjects = {
        select = {
          enable = true,
          -- Jump forward to the start of the textobject
          lookahead = true,
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'around function' },
            ['if'] = { query = '@function.inner', desc = 'inner function' },
            ['am'] = { query = '@function.outer', desc = 'around method' },
            ['im'] = { query = '@function.inner', desc = 'inner method' },
            ['ac'] = { query = '@class.outer', desc = 'around class' },
            ['ic'] = { query = '@class.inner', desc = 'inner class' },
            ['aa'] = { query = '@parameter.outer', desc = 'around argument' },
            ['ia'] = { query = '@parameter.inner', desc = 'inner argument' },
            ['ai'] = { query = '@conditional.outer', desc = 'around if/conditional' },
            ['ii'] = { query = '@conditional.inner', desc = 'inner if/conditional' },
            ['al'] = { query = '@loop.outer', desc = 'around loop' },
            ['il'] = { query = '@loop.inner', desc = 'inner loop' },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = { query = '@function.outer', desc = 'next method/function start' },
            [']c'] = { query = '@class.outer', desc = 'next class start' },
            [']a'] = { query = '@parameter.inner', desc = 'next argument' },
          },
          goto_next_end = {
            [']M'] = { query = '@function.outer', desc = 'next method/function end' },
            [']C'] = { query = '@class.outer', desc = 'next class end' },
          },
          goto_previous_start = {
            ['[m'] = { query = '@function.outer', desc = 'prev method/function start' },
            ['[c'] = { query = '@class.outer', desc = 'prev class start' },
            ['[a'] = { query = '@parameter.inner', desc = 'prev argument' },
          },
          goto_previous_end = {
            ['[M'] = { query = '@function.outer', desc = 'prev method/function end' },
            ['[C'] = { query = '@class.outer', desc = 'prev class end' },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = { query = '@parameter.inner', desc = 'swap with next argument' },
          },
          swap_previous = {
            ['<leader>A'] = { query = '@parameter.inner', desc = 'swap with prev argument' },
          },
        },
      },
    }
  end,
}
