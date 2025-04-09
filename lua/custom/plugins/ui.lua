-- UI enhancements for better aesthetics with Nerd Fonts
return {
  -- Update tokyonight theme to better work with Nerd Fonts
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = false,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    },
  },
  
  -- Add dashboard when opening Neovim without a file
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("dashboard").setup({
        theme = "doom",
        config = {
          header = {
            "                                                       ",
            "                                                       ",
            "                                                       ",
            " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
            " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
            " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
            " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
            " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
            " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
            "                                                       ",
            "                                                       ",
          },
          center = {
            { icon = "  ", desc = "New File", action = "enew" },
            { icon = "  ", desc = "Find File", key = "SPC s f", action = "Telescope find_files" },
            { icon = "  ", desc = "Recent Files", key = "SPC s .", action = "Telescope oldfiles" },
            { icon = "  ", desc = "Find Word", key = "SPC s g", action = "Telescope live_grep" },
          },
          footer = { "Using FiraCode Nerd Font" }
        }
      })
    end
  },
  
  -- Enhanced statusline with Nerd Font icons
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "tokyonight",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      })
    end
  }
}