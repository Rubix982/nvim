-- Global JavaScript keymaps and commands
return {
  config = function()
    -- Create keybinding to manually trigger completion
    vim.keymap.set('i', '<C-x><C-o>', function() 
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, true, true), 'n', true)
    end, { noremap = true, desc = 'Trigger omnifunc completion' })
    
    -- Create a diagnostic toggle command
    vim.api.nvim_create_user_command("DiagnosticsToggle", function()
      local mode = vim.diagnostic.config().virtual_text and false or true
      vim.diagnostic.config({ virtual_text = mode })
      print("Diagnostics " .. (mode and "enabled" or "disabled"))
    end, {})
    
    -- Add keybindings for easier completion
    vim.keymap.set('i', '<C-Space>', function()
      -- Try both types of completion
      local cmp_available, cmp = pcall(require, 'cmp')
      if cmp_available then
        cmp.complete()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, true, true), 'n', true)
      end
    end, { noremap = true, desc = 'Trigger completion' })
    
    -- Create an info message to show available commands
    vim.api.nvim_create_user_command("JSHelp", function()
      print("JavaScript Help:")
      print("• Press <C-Space> in insert mode to trigger completion")
      print("• Run :LSPCheck to see active language servers")
      print("• Run :LspRestart to restart language servers")
      print("• Run :DiagnosticsToggle to toggle diagnostics")
    end, {})
    
    -- Print startup message
    vim.defer_fn(function()
      print("JavaScript completion available with <C-Space> in insert mode")
      print("Type :JSHelp for more information")
    end, 1000)
  end
}