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
}