-- Icons for Neovim UI
return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup({
        -- Enable icons by default
        default = true,
        -- Enable color icons
        color_icons = true,
        -- Set icon color based on filetype
        strict = true,
      })
    end
  }
}