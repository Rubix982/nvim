-- Add inline git blame and other git features
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- Leave the signs as they are
      -- Enable blame functionality
      current_line_blame = true,  -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 200,          -- Make delay shorter for testing
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      
      -- Add custom keymaps
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        
        -- Toggle inline blame with <leader>tb and easier <leader>b
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle git blame' })
        map('n', '<leader>b', gs.toggle_current_line_blame, { desc = 'Toggle git blame' })
        
        -- Show blame for current line
        map('n', '<leader>gb', gs.blame_line, { desc = 'Git blame current line' })
        
        -- Show full blame (opens a blame window)
        map('n', '<leader>gB', function() gs.blame_line{full=true} end, { desc = 'Git blame line (full)' })
      end,
    },
  },
}