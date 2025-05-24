-- Buffer navigation utilities
return {
  {
    "folke/which-key.nvim",
    optional = true,
    event = "VeryLazy",
    opts = {
      defaults = {
        ["<leader>b"] = { name = "+Buffer" },
      },
    },
  },
  {
    dir = ".",
    name = "buffer-navigation",
    config = function()
      -- Keybindings for cycling through buffers
      -- Standard Tab and Shift+Tab to move between buffers
      vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = "Next buffer", silent = true })
      vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = "Previous buffer", silent = true })
      
      -- Alt+Left and Alt+Right to move between buffers
      vim.keymap.set('n', '<A-Left>', ':bprevious<CR>', { desc = "Previous buffer", silent = true })
      vim.keymap.set('n', '<A-Right>', ':bnext<CR>', { desc = "Next buffer", silent = true })
      
      -- Leader keys for buffer navigation
      vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = "Next buffer", silent = true })
      vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = "Previous buffer", silent = true })
      
      -- Show buffer list with leader+b
      vim.keymap.set('n', '<leader>bb', ':buffers<CR>', { desc = "List all buffers", silent = true })
      
      -- Close current buffer
      vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Delete buffer", silent = true })
      
      -- Go to last edited buffer
      vim.keymap.set('n', '<leader>bl', '<C-^>', { desc = "Last buffer", silent = true })
      
      -- Switch to buffer by number
      for i = 1, 9 do
        vim.keymap.set('n', '<leader>' .. i, ':' .. i .. 'b<CR>', { desc = "Buffer " .. i, silent = true })
      end
    end,
  },
  
  -- Add Telescope buffer picker
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { 
        "<leader>fb", 
        function() 
          require('telescope.builtin').buffers({ 
            sort_mru = true,
            sort_lastused = true,
          }) 
        end, 
        desc = "Find buffers (MRU order)" 
      },
    },
  },
}