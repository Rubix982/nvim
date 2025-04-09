-- Terminal plugin configuration
return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Size can be a number or function
        size = 15,
        -- Open in horizontal split
        direction = 'horizontal',
        -- Add custom mappings
        open_mapping = [[<C-\>]],
        -- Hide the number column 
        hide_numbers = true,
        -- Add shade to terminal window
        shade_terminals = true,
        -- Auto scroll to end when entering terminal
        autoscroll = true,
        -- Close terminal when process exits
        close_on_exit = true,
      })
      
      -- Custom keymaps
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        -- Escape terminal mode
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        -- Navigate between windows in terminal mode
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      -- Auto command to set terminal keymaps
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
      
      -- Numbered terminals (allows multiple terminals)
      vim.keymap.set('n', '<leader>t1', '<Cmd>1ToggleTerm direction=horizontal<CR>', {desc = 'Toggle terminal #1'})
      vim.keymap.set('n', '<leader>t2', '<Cmd>2ToggleTerm direction=horizontal<CR>', {desc = 'Toggle terminal #2'})
      vim.keymap.set('n', '<leader>t3', '<Cmd>3ToggleTerm direction=horizontal<CR>', {desc = 'Toggle terminal #3'})
      
      -- Split terminal layouts
      vim.keymap.set('n', '<leader>th', '<Cmd>ToggleTerm direction=horizontal<CR>', {desc = 'Toggle horizontal terminal'})
      vim.keymap.set('n', '<leader>tv', '<Cmd>ToggleTerm direction=vertical size=80<CR>', {desc = 'Toggle vertical terminal'})
      vim.keymap.set('n', '<leader>tf', '<Cmd>ToggleTerm direction=float<CR>', {desc = 'Toggle floating terminal'})
      
      -- Terminal layout commands
      vim.keymap.set('n', '<leader>ts', '<Cmd>ToggleTermSendCurrentLine<CR>', {desc = 'Send current line to terminal'})
      vim.keymap.set('v', '<leader>ts', '<Cmd>ToggleTermSendVisualSelection<CR>', {desc = 'Send selection to terminal'})
      
      -- Terminal toggles for IDE-like experience
      vim.api.nvim_create_user_command('TermSplit', function(opts)
        -- Split layout with editor and two terminals
        vim.cmd('vsplit')
        vim.cmd('wincmd l')
        vim.cmd('1ToggleTerm direction=horizontal')
        vim.cmd('resize 10')
        vim.cmd('wincmd h')
        vim.cmd('split')
        vim.cmd('wincmd j')
        vim.cmd('2ToggleTerm direction=horizontal')
        vim.cmd('resize 10')
        vim.cmd('wincmd k')
      end, {})
    end
  }
}