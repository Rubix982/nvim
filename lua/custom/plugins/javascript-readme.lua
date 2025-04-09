-- JavaScript/TypeScript Feature Guide
return {
  {
    "folke/which-key.nvim",
    optional = true,
    config = function(_, opts)
      -- Add JavaScript keybindings to which-key
      local wk = require("which-key")
      wk.register({
        ["<leader>j"] = {
          name = "JavaScript",
          a = { "Code Action" },
          i = { "Organize Imports" },
          f = { "Format Code" },
          d = { "Show Diagnostic Details" },
          l = { "List All Problems" },
          g = { "Generate JSDoc" },
          D = { "Debug Info" },
          c = { "Create Config" },
          A = { "Force Attach LSP" },
        },
      })
      
      -- Create a command to show JavaScript features
      vim.api.nvim_create_user_command("JSFeatures", function()
        local lines = {
          "JavaScript/TypeScript Features",
          "===========================",
          "",
          "Intellisense & Autocompletion:",
          "- Automatic type information (hover with 'K')",
          "- Auto-import suggestions",
          "- Parameter name and type hints",
          "- Function return type hints",
          "",
          "Navigation:",
          "- Go to definition: gd",
          "- Go to references: gr",
          "- Go to implementation: gI",
          "",
          "Diagnostics:",
          "- Errors and warnings shown in gutter",
          "- Detailed diagnostic information on hover",
          "",
          "Refactoring:",
          "- <leader>ja - Code actions (imports, refactors)",
          "- <leader>ji - Organize imports",
          "- <leader>jf - Format current file",
          "- <leader>jd - Show diagnostic details",
          "- <leader>jl - List all problems",
          "",
          "Documentation:",
          "- JSDoc generation with <leader>jg (via Neogen)",
          "",
          "Troubleshooting:",
          "- <leader>jD - Show JavaScript debug info",
          "- <leader>jc - Create jsconfig.json in project root",
          "- <leader>jA - Force attach TypeScript LSP to current buffer",
        }
        
        -- Display in a floating window
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        
        local width = 60
        local height = #lines
        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          row = math.floor((vim.o.lines - height) / 2),
          col = math.floor((vim.o.columns - width) / 2),
          style = "minimal",
          border = "rounded",
        })
        
        -- Set buffer options
        vim.api.nvim_buf_set_option(buf, "modifiable", false)
        vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
        
        -- Close on any key press
        vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true })
      end, {})
    end,
  },
}