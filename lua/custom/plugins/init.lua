-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Fix for missing Python LSP configurations
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Add pyright configuration (standard Python LSP)
        pyright = {},
        -- Add ruff configuration (updated from deprecated ruff_lsp)
        ruff = {},
      },
    },
    config = function(_, opts)
      -- Make sure these servers are properly set up
      local lspconfig = require('lspconfig')
      
      -- Setup pyright
      if lspconfig.pyright then
        lspconfig.pyright.setup({
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })
      end
      
      -- Setup ruff (updated from deprecated ruff_lsp)
      if lspconfig.ruff then
        lspconfig.ruff.setup({
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })
      end
      
      -- Sourcery has been removed as it's not properly configured
    end,
  },
  
  -- Make sure these servers are installed
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
      },
    },
  },
}
