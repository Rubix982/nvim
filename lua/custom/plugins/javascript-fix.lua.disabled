-- Minimal JavaScript intellisense configuration - this overrides previous configs
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Define the on_attach function for JavaScript/TypeScript files
      local on_attach = function(client, bufnr)
        -- Enable omnifunc completion
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        
        -- Create keymaps for JavaScript-specific functionality
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        
        -- Enable intellisense specifically for this buffer
        local cmp = require('cmp')
        cmp.setup.buffer({
          enabled = true,
          sources = {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
          },
        })
        
        -- Print a message confirming LSP attachment
        print("LSP client " .. client.name .. " attached to buffer: " .. vim.api.nvim_buf_get_name(bufnr))
      end
      
      -- Configure capabilities for the server
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      
      -- Set up the TypeScript language server directly
      require('lspconfig')['tsserver'].setup({
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_dir = function(fname)
          -- Look for package.json, tsconfig.json, jsconfig.json or go to the top level
          return require('lspconfig.util').find_package_json_ancestor(fname) or
                 require('lspconfig.util').find_node_modules_ancestor(fname) or
                 require('lspconfig.util').root_pattern("tsconfig.json", "jsconfig.json")(fname) or
                 vim.fn.getcwd()
        end,
        single_file_support = true,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          javascript = {
            implicitProjectConfig = {
              checkJs = true,
            },
          },
        },
      })
      
      -- Add a command to check the LSP status
      vim.api.nvim_create_user_command("LSPCheck", function()
        local buf = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_active_clients({ bufnr = buf })
        
        if #clients == 0 then
          print("No LSP clients attached to this buffer.")
        else
          for _, client in ipairs(clients) do
            print(string.format("LSP client attached: %s (id: %d)", client.name, client.id))
          end
        end
      end, {})
      
      -- Also define a function to restart the TypeScript server
      vim.api.nvim_create_user_command("LspRestart", function()
        -- Stop all LSP clients
        for _, client in ipairs(vim.lsp.get_active_clients()) do
          vim.lsp.stop_client(client.id)
        end
        
        -- Clear all LSP diagnostics
        vim.diagnostic.reset()
        
        -- Delay to ensure everything is stopped
        vim.defer_fn(function()
          -- Restart the LSP for the current buffer
          vim.cmd("edit")
          print("LSP servers restarted")
        end, 500)
      end, {})
    end
  },
  
  -- Configure nvim-cmp for completion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
        }),
        completion = {
          autocomplete = false,  -- Disable automatic popup to avoid any errors
        },
      })
      
      -- Create a key mapping to manually trigger completion
      vim.keymap.set('i', '<C-Space>', function()
        cmp.complete()
      end, { noremap = true, silent = true })
    end
  },
  
  -- Make sure TypeScript language server is installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      
      -- Add TypeScript tools
      table.insert(opts.ensure_installed, "typescript-language-server")
      
      return opts
    end
  },
}