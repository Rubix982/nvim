-- Enhanced icons for Neovim UI
return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    priority = 1000, -- Load early for other plugins to use
    config = function()
      require("nvim-web-devicons").setup({
        -- Enable folder icons
        default = true,
        -- Enable colored icons
        color_icons = true,
        -- Use icons for folders in all plugins
        strict = true,
        -- Override specific icons (uncomment to customize)
        override = {
          -- For example:
          -- ["dockerfile"] = {
          --   icon = "",
          --   color = "#458ee6",
          --   name = "Dockerfile",
          -- },
          -- Add your custom file icons here
        },
        -- Same as `override` but specifically for overriding globally defined icons
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore",
          },
          [".env"] = {
            icon = "",
            color = "#89e051",
            name = "Env",
          },
          ["dockerfile"] = {
            icon = "",
            color = "#458ee6",
            name = "Dockerfile"
          },
          ["docker-compose.yml"] = {
            icon = "",
            color = "#458ee6",
            name = "DockerCompose"
          },
          ["package.json"] = {
            icon = "",
            color = "#e8274b",
            name = "PackageJson"
          },
          ["tsconfig.json"] = {
            icon = "",
            color = "#3178c6", 
            name = "TSConfig"
          },
        },
        -- Same as `override` but specifically for overriding by extension
        override_by_extension = {
          ["tsx"] = {
            icon = "",
            color = "#61dafb",
            name = "TSX",
          },
          ["jsx"] = {
            icon = "",
            color = "#61dafb", 
            name = "JSX",
          },
          ["ts"] = {
            icon = "",
            color = "#3178c6",
            name = "TypeScript",
          },
          ["js"] = {
            icon = "",
            color = "#f7df1e",
            name = "JavaScript",
          },
          ["py"] = {
            icon = "",
            color = "#ffbc03",
            name = "Python",
          },
          ["sh"] = {
            icon = "",
            color = "#89e051",
            name = "Bash",
          },
          ["lua"] = {
            icon = "",
            color = "#51a0cf",
            name = "Lua",
          },
        },
      })
    end
  },
  
  -- Update the Neo-tree config to use better folder icons
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      default_component_configs = {
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          -- You can use any Nerd Font icons
          default = "",
          highlight = "NeoTreeFileIcon",
        },
        git_status = {
          symbols = {
            -- Change type
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            -- Status type
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
      },
    },
  },
}