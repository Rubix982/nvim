-- Python provider configuration
return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Set Python provider to use the version with pynvim installed
      vim.g.python3_host_prog = "/Users/saif.islam/.pyenv/shims/python3"
    end
  }
}