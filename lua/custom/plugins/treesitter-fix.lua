-- Fix for Treesitter errors
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Force update parsers with errors
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        callback = function()
          vim.schedule(function()
            -- Force update problematic parsers
            vim.cmd("TSUpdate dockerfile typescript query")
          end)
        end,
      })

      -- Ensure the core languages are installed and up to date
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript", 
        "dockerfile",
      })
      
      -- Ignore specific errors for parsers that are having issues
      opts.ignore_install = opts.ignore_install or {}
      
      -- Disable problematic parser features if needed
      opts.highlight = opts.highlight or {}
      opts.highlight.disable = opts.highlight.disable or {}
      
      -- Disable specific problematic parsers to prevent errors
      vim.list_extend(opts.highlight.disable, {"query"})
      
      -- Handle the specific query parser error by removing and reinstalling
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Remove the query highlights file that's causing issues
          vim.schedule(function()
            -- Try to fix the query parser and its query files
            local query_file = "/Users/saif.islam/.local/share/nvim/lazy/nvim-treesitter/queries/query/highlights.scm"
            local removed = vim.fn.delete(query_file)
            
            -- Install official parsers
            vim.cmd("TSInstall! query")
          end)
        end,
        once = true,
      })
      
      return opts
    end,
  }
}