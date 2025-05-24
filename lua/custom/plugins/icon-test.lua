-- Test file to check if Nerd Fonts are displaying correctly
return {
  dir = ".",
  name = "icon-test",
  keys = {
    { 
      "<leader>ti", 
      function()
        -- Create a scratch buffer
        local bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
        
        -- Open a floating window
        local width = 80
        local height = 20
        local win_opts = {
          relative = 'editor',
          width = width,
          height = height,
          row = math.floor((vim.o.lines - height) / 2),
          col = math.floor((vim.o.columns - width) / 2),
          style = 'minimal',
          border = 'rounded',
          title = ' Icon Test ',
          title_pos = 'center',
        }
        local winnr = vim.api.nvim_open_win(bufnr, true, win_opts)
        
        -- Add content to test Nerd Font icons
        local lines = {
          "If you see boxes instead of icons, your Nerd Font is not working properly.",
          "",
          "# Developer Icons:",
          "  Dev:     JavaScript:   TypeScript:   Python:  ",
          "  React:   Vue:         Angular:      Git:     ",
          "  Docker:   AWS:          Database:     Test:    ",
          "",
          "# File Icons:",
          "  File:   Dir:   Config:   Text:  ",
          "  Image:   Video:   Audio:     Archive:  ",
          "  JSON:   YAML:   XML:      HTML:  ",
          "",
          "# Git Status Icons:",
          "  Added: ✚  Modified:   Deleted: ✖  Renamed: 󰁕",
          "  Untracked:   Ignored:   Unstaged: 󰄱  Staged:  ",
          "",
          "",
          "Press 'q' to close this window",
        }
        
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        
        -- Set buffer options
        vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
        
        -- Add mapping to close the window
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', 
          '<cmd>lua vim.api.nvim_win_close(0, true)<CR>', 
          {noremap = true, silent = true})
          
        -- Highlight as markdown
        vim.api.nvim_buf_set_option(bufnr, 'filetype', 'markdown')
      end,
      desc = "Test Nerd Font Icons" 
    },
  },
}