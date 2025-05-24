-- Improved Neo-tree configuration
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree toggle left reveal<CR>', { desc = 'Toggle NeoTree' } },
    { '<leader>e', ':Neotree toggle left reveal<CR>', { desc = 'Toggle NeoTree' } },
    { '<leader>o', ':Neotree focus left reveal<CR>', { desc = 'Focus NeoTree' } },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    
    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "",
        highlight = "NeoTreeFileIcon",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          -- Change type
          added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = "✖", -- this can only be used in the git_status source
          renamed   = "󰁕", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        },
      },
    },
    
    window = {
      position = "left",
      width = 35, -- Wider window
      mappings = {
        ["\\"] = "close_window",
        ["<space>"] = { 
          "toggle_node", 
          nowait = false, -- false allows for using space in search
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "revert_preview",
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["l"] = "focus_preview",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["w"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["a"] = { 
          "add",
          config = {
            show_path = "relative" -- Shows a relative path from the root
          }
        },
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes a source and a destination
        ["m"] = "move", -- takes a source and a destination
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
      },
    },
    
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will be displayed but grayed out
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = true, -- only works on Windows
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
          "node_modules",
        },
        hide_by_pattern = { -- uses glob style patterns
          "*.meta",
          "*/\\.git/*",
          "*/\\.cache/*",
        },
        always_show = { -- remains visible even if other settings would hide it
          ".gitignored",
          ".env",
        },
        never_show = { -- remains hidden even if visible is toggled to true
          ".DS_Store",
          "thumbs.db",
        },
        never_show_by_pattern = { -- uses glob style patterns
          "*.meta",
        },
      },
      follow_current_file = {
        enabled = true, -- auto-focuses on current file when opening
        leave_dirs_open = true, -- leaves the parent directories open
      },
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_default", -- open_default / open_current / disabled
      use_libuv_file_watcher = true, -- refresh tree when files change
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        },
      },
    },
    
    buffers = {
      follow_current_file = {
        enabled = true, -- auto focuses on current file
        leave_dirs_open = true, -- leaves parent directories open
      },
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
        },
      },
    },
    
    git_status = {
      window = {
        mappings = {
          ["A"]  = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        },
      },
    },
  },
}