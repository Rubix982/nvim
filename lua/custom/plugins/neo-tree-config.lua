-- Enhanced Neo-tree configuration
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    -- Enable auto-refresh on file changes
    auto_refresh = true,
    
    -- Add FS watcher
    filesystem = {
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true, -- only works on Windows
        hide_by_name = {
          ".git",
          ".DS_Store",
        },
      },
      hijack_netrw_behavior = "open_default",
      window = {
        mappings = {
          -- Explicitly set refresh mapping
          ["R"] = "refresh",
          -- Toggle hidden files/folders
          ["H"] = "toggle_hidden",
          -- Add new item (file or directory)
          ["a"] = {
            "add",
            config = {
              show_path = "relative"
            }
          },
          -- Other useful mappings
          ["d"] = "delete",
          ["r"] = "rename",
          ["c"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
        }
      }
    },
    
    -- Default window position
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["<space>"] = "none", -- Disable space mapping to preserve leader
      }
    },
    
    -- Default key mappings
    event_handlers = {
      {
        event = "file_added",
        handler = function(file_path)
          -- Auto-refresh when file is added
          require("neo-tree.command").execute({ action = "refresh" })
        end
      },
      {
        event = "file_deleted",
        handler = function(file_path)
          -- Auto-refresh when file is deleted 
          require("neo-tree.command").execute({ action = "refresh" })
        end
      }
    }
  }
}