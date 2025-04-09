-- Node.js provider configuration
return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Disable Node.js provider to eliminate the warning
      vim.g.loaded_node_provider = 0
      
      -- Alternative: If you need Node.js support, uncomment the following line
      -- vim.g.node_host_prog = "/Users/saif.islam/.nvm/versions/node/v22.14.0/lib/node_modules/neovim/bin/cli.js"
    end
  }
}