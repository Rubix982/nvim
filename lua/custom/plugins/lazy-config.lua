-- Configure Lazy plugin manager settings
return {
  {
    "folke/lazy.nvim",
    priority = 1000,
    config = function()
      -- Disable hererocks to avoid the luarocks dependency error
      require("lazy").setup({
        rocks = {
          -- Disable hererocks which requires luarocks
          hererocks = false
        }
      })
    end
  }
}