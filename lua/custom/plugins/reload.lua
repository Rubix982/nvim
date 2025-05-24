-- Add a simple command to reload Neovim configuration
return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>r"] = { name = "+reload" },
      },
    },
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    dir = ".",
    name = "neovim-reload",
    keys = {
      {
        "<leader>rr",
        function()
          -- Clear loaded modules
          for name, _ in pairs(package.loaded) do
            if name:match("^custom") or name:match("^kickstart") then
              package.loaded[name] = nil
            end
          end

          -- Source init.lua
          vim.cmd("source ~/.config/nvim/init.lua")
          print("Neovim configuration reloaded!")
        end,
        desc = "Reload Neovim configuration",
      },
    },
  },
}