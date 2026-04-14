-- JavaScript/TypeScript LSP configuration
-- This enables intellisense for JavaScript and TypeScript files

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function(_, opts)
      -- Configure TypeScript server
      local servers = require('mason-lspconfig').get_installed_servers()
      
      -- Add TypeScript server with enhanced capabilities
      local tsserver_config = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            suggest = {
              completeFunctionCalls = true,
              includeAutomaticOptionalChainCompletions = true,
              includeCompletionsForImportStatements = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            suggest = {
              completeFunctionCalls = true,
              includeAutomaticOptionalChainCompletions = true,
              includeCompletionsForImportStatements = true,
            },
            implicitProjectConfig = {
              checkJs = true,
              module = "ESNext",
            },
          },
        },
        -- Add root_dir to help find project files
        root_dir = function(fname)
          return require('lspconfig.util').find_git_ancestor(fname) or
                 require('lspconfig.util').root_pattern("jsconfig.json", "tsconfig.json", "package.json")(fname) or
                 vim.fn.getcwd()
        end,
      }
      
      -- Create a custom on_attach function for JavaScript/TypeScript
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        
        -- Note: autocomplete is now handled by javascript-completion.lua
        
        -- Enable inlay hints if available
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
        
        -- Define key mappings for JavaScript specific functionality if needed
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'JS: ' .. desc })
        end
        
        -- LSP code action functions for JavaScript/TypeScript
        map('<leader>ja', vim.lsp.buf.code_action, 'Code Action')
        map('<leader>ji', function() vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.api.nvim_buf_get_name(0)}}) end, 'Organize Imports')
        map('<leader>jf', function() vim.lsp.buf.format({ async = true }) end, 'Format Code')
      end
      
      -- Setup TypeScript server (using typescript-language-server instead of deprecated tsserver)
      require('lspconfig')['typescript'].setup({
        capabilities = tsserver_config.capabilities,
        on_attach = on_attach,
        settings = tsserver_config.settings,
        root_dir = tsserver_config.root_dir,
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        -- Initialize on startup
        init_options = {
          hostInfo = "neovim",
          maxTsServerMemory = 4096,
          tsserver = {
            logVerbosity = "normal",
            trace = "messages",
          },
        },
        flags = {
          debounce_text_changes = 150,
          allow_incremental_sync = true,
        },
      })
      
      -- Add eslint_d for linting JavaScript/TypeScript
      if vim.fn.executable('eslint_d') == 1 then
        require('lspconfig')['eslint'].setup({
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
          on_attach = function(client, bufnr)
            -- Run ESLint autofix on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        })
      end
    end,
  },
  
  -- Add Prettier for formatting JavaScript/TypeScript
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
      },
      -- Use this option instead of nested formatting
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}