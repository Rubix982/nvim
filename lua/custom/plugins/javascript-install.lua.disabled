-- Ensure TypeScript language server and other JavaScript tools are installed
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      
      -- Add TypeScript language server (ts_ls)
      table.insert(opts.ensure_installed, "typescript-language-server")
      
      -- Add JavaScript linters and formatters
      table.insert(opts.ensure_installed, "eslint_d")
      table.insert(opts.ensure_installed, "prettierd")
      
      -- Add JSON language server
      table.insert(opts.ensure_installed, "json-lsp")
      
      return opts
    end,
  },
  
  -- Configure linting with null-ls
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts = opts or {}
      opts.sources = opts.sources or {}
      
      -- Add ESLint and Prettier sources if available
      local sources = {
        null_ls.builtins.diagnostics.eslint_d.with({
          diagnostics_format = "[eslint] #{m}\n(#{c})"
        }),
        null_ls.builtins.formatting.prettierd,
      }
      
      -- Extend existing sources
      for _, source in ipairs(sources) do
        table.insert(opts.sources, source)
      end
      
      return opts
    end,
  },
}