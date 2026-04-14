-- Enhanced autocompletion configuration for JavaScript
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function(_, opts)
      local cmp = require("cmp")
      
      -- Configure cmp for JavaScript/TypeScript files
      local js_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json" }
      
      -- Define a safer completion setup for JavaScript
      local js_completion_config = {
        enabled = function()
          -- Disable in comments
          local context = require('cmp.config.context')
          if context.in_treesitter_capture('comment') or context.in_syntax_group('Comment') then
            return false
          end
          return true
        end,
        
        -- Use a safer autocomplete trigger
        completion = {
          autocomplete = { 'TextChanged' },
        },
        
        -- Use simple formatting without icons for safety
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            
            return vim_item
          end,
        },
        
        -- Customize the order of completion sources for JS files
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }
      
      -- Apply this config to JavaScript/TypeScript files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = js_filetypes,
        callback = function()
          cmp.setup.buffer(js_completion_config)
        end
      })
      
      -- Load JavaScript/TypeScript specific snippets
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "./snippets", "./node_modules/friendly-snippets" },
        include = js_filetypes,
      })
    end,
  },
  
  -- Add JSDoc generation for JavaScript
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        enabled = true,
        languages = {
          javascript = {
            template = {
              annotation_convention = "jsdoc",
            },
          },
          typescript = {
            template = {
              annotation_convention = "tsdoc",
            },
          },
        },
      })
      
      -- Add key mapping for generating documentation
      vim.keymap.set("n", "<Leader>jg", function() 
        require("neogen").generate() 
      end, { desc = "Generate JSDoc" })
    end,
  },
}