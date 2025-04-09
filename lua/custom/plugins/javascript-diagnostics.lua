-- JavaScript/TypeScript diagnostics configuration
return {
  {
    "neovim/nvim-lspconfig",
    config = function(_, _)
      -- Set up JavaScript/TypeScript diagnostic signs
      local signs = {
        Error = "✘",
        Warn = "▲",
        Hint = "⚑",
        Info = "»"
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Configure diagnostics display for JavaScript/TypeScript files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        callback = function()
          -- Use a safer diagnostic config for JS files
          local config = {
            virtual_text = {
              prefix = '●', 
              source = "if_many",
            },
            float = {
              source = "always",
              border = "rounded",
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
          }
          
          -- Apply the configuration safely
          pcall(vim.diagnostic.config, config)
          
          -- Create additional keymaps for JavaScript diagnostics
          vim.keymap.set('n', '<leader>jd', vim.diagnostic.open_float, 
            { buffer = true, desc = "JS: Show Diagnostic Details" })
          
          vim.keymap.set('n', '<leader>jl', function()
            vim.diagnostic.setloclist({ severity = { min = vim.diagnostic.severity.WARN } })
          end, { buffer = true, desc = "JS: List All Problems" })
        end
      })
    end,
  },
}