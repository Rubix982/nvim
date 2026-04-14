-- Add convenient Git keymaps
return {
  {
    "folke/which-key.nvim",
    optional = true,
    event = "VeryLazy",
    opts = {
      defaults = {
        ["<leader>g"] = { name = "+Git" },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      -- Direct keymaps for git blame without needing to use the leader key menu
      { "<F2>", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle Git Blame" },
      
      -- Git blame commands
      { "<leader>gb", "<cmd>Gitsigns blame_line<CR>", desc = "Git Blame Line" },
      { "<leader>gB", "<cmd>Gitsigns blame_line {full=true}<CR>", desc = "Git Blame Line (Full)" },
      { "<leader>gC", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle Git Blame" },
      
      -- Additional Keymaps with <leader>g prefix
      { "<leader>gd", "<cmd>Gitsigns diffthis<CR>", desc = "Git Diff" },
      { "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview Hunk" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset Hunk" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", desc = "Stage Hunk" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "Undo Stage Hunk" },
    },
  },
  -- Diffview keymaps (GoLand-style diff & change sidebar)
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
    keys = {
      { '<leader>gD', '<cmd>DiffviewOpen<CR>', desc = 'Diff view (all changes)' },
      { '<leader>gf', '<cmd>DiffviewFileHistory %<CR>', desc = 'File history (current file)' },
      { '<leader>gF', '<cmd>DiffviewFileHistory<CR>', desc = 'File history (branch)' },
      { '<leader>gq', '<cmd>DiffviewClose<CR>', desc = 'Close diff view' },
    },
    config = function()
      require('diffview').setup {
        enhanced_diff_hl = true,
        view = {
          default = { layout = 'diff2_horizontal' },
          merge_tool = { layout = 'diff3_mixed' },
          file_history = { layout = 'diff2_horizontal' },
        },
        file_panel = {
          listing_style = 'tree',
          tree_options = {
            flatten_dirs = true,
            folder_statuses = 'only_folded',
          },
          win_config = {
            position = 'left',
            width = 35,
          },
        },
      }
    end,
  },
}