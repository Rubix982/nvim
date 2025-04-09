-- Fix for markdown linter by adding it to Mason
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "markdownlint", -- Add markdownlint to be installed
      })
      return opts
    end
  },
  
  -- Properly configure linters when installed
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      
      -- Only enable markdown linting if markdownlint is available
      local executable_exists = function(name)
        return vim.fn.executable(name) > 0
      end
      
      if executable_exists("markdownlint") then
        -- Enable markdownlint if installed
        lint.linters_by_ft = lint.linters_by_ft or {}
        lint.linters_by_ft["markdown"] = { "markdownlint" }
      end
    end
  }
}