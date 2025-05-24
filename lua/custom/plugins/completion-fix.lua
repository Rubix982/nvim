-- Fix for LSP completion errors
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Override the built-in LSP omnicomplete to handle nil range errors
      local orig_omnifunc = vim.lsp.omnifunc
      
      -- Create a patched omnifunc that handles errors
      vim.lsp.omnifunc = function(findstart, base)
        -- Protect against LSP errors
        local status, result = pcall(function()
          return orig_omnifunc(findstart, base)
        end)
        
        if not status then
          vim.notify("LSP completion error: " .. vim.inspect(result), vim.log.levels.WARN)
          
          -- Return safe defaults
          if findstart == 1 then
            return vim.fn.col('.') - 1
          else
            return {}
          end
        end
        
        return result
      end
      
      -- Create a special command to toggle our custom omnifunc
      vim.api.nvim_create_user_command("FixCompletion", function()
        -- Enable a more robust completion for the current buffer
        vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        
        -- Create a backup completion handler using nvim-cmp
        local has_cmp, cmp = pcall(require, 'cmp')
        if has_cmp then
          cmp.setup.buffer({
            completion = {
              autocomplete = false,
            },
            mapping = cmp.mapping.preset.insert({
              -- Use Tab for completion
              ['<Tab>'] = cmp.mapping.confirm({ select = true }),
              ['<C-Space>'] = cmp.mapping.complete(),
            }),
          })
          
          -- Map Ctrl+Space to trigger completion manually
          vim.keymap.set('i', '<C-Space>', function()
            cmp.complete()
          end, { buffer = 0, noremap = true, silent = true })
        end
        
        -- Also enable keyword completion as backup
        vim.opt_local.complete = ".,w,b,u,t,i"
        vim.opt_local.completeopt = "menu,menuone,noinsert"
        
        print("Fixed completion enabled for current buffer. Use <C-Space> to trigger.")
      end, {})
      
      -- Add mapping for the fix
      vim.keymap.set('n', '<leader>fc', ':FixCompletion<CR>', { noremap = true, silent = true, desc = "Fix completion for current buffer" })
    end
  }
}