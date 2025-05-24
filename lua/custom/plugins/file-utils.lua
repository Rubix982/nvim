-- File utilities for Neovim
return {
  {
    "folke/which-key.nvim",
    optional = true,
    event = "VeryLazy",
    opts = {
      defaults = {
        ["<leader>f"] = { name = "+File" },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      -- Reveal current file in Neo-tree
      { 
        "<leader>fr", 
        ":Neotree reveal<CR>", 
        desc = "Reveal File in Neo-tree" 
      },
    },
  },
  {
    dir = ".",
    name = "file-utils",
    keys = {
      -- Show full path of current file
      { 
        "<leader>fp", 
        function()
          local path = vim.fn.expand('%:p')
          vim.notify('File path: ' .. path, vim.log.levels.INFO)
          print('File path: ' .. path)
        end,
        desc = "Show Full File Path" 
      },
      
      -- Copy full path to clipboard
      { 
        "<leader>fy", 
        function()
          local path = vim.fn.expand('%:p')
          vim.fn.setreg('+', path)
          vim.notify('Copied to clipboard: ' .. path, vim.log.levels.INFO)
        end,
        desc = "Copy Full Path to Clipboard" 
      },
      
      -- Show shorter path (relative to project root)
      { 
        "<leader>fP", 
        function()
          local full_path = vim.fn.expand('%:p')
          local cwd = vim.fn.getcwd()
          local rel_path = full_path:gsub(cwd, '')
          if rel_path:sub(1, 1) == '/' then
            rel_path = rel_path:sub(2)
          end
          vim.notify('Relative path: ' .. rel_path, vim.log.levels.INFO)
          print('Relative path: ' .. rel_path)
        end,
        desc = "Show Relative File Path" 
      },
    },
  },
}