-- Advanced Git functionality similar to JetBrains
return {
  -- Neogit - Magit-like interface for Git
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim", -- Enhanced diff view
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup({
        -- Enable the diff popup
        kind = "split",
        -- Enable integration with diffview.nvim
        integrations = {
          diffview = true,
        },
        -- Similar to shelf, this enables stashing
        sections = {
          stashes = {
            folded = false,
          },
        },
        -- Enable commit view to see exactly what will be committed
        commit_view = {
          kind = "split",
        },
      })
      
      -- Keymaps
      vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { desc = "Open Neogit" })
    end,
  },
  
  -- Git signs in the gutter with staging capabilities
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        -- Enable line by line staging
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          
          -- Navigation between hunks
          vim.keymap.set("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Next hunk" })
          
          vim.keymap.set("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Previous hunk" })
          
          -- Stage hunks (partial staging)
          vim.keymap.set({"n", "v"}, "<leader>gs", ":Gitsigns stage_hunk<CR>", 
            { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set("n", "<leader>gS", gs.stage_buffer, 
            { buffer = bufnr, desc = "Stage buffer" })
          
          -- Unstage hunks
          vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, 
            { buffer = bufnr, desc = "Unstage hunk" })
          vim.keymap.set("n", "<leader>gR", gs.reset_buffer, 
            { buffer = bufnr, desc = "Reset buffer" })
          
          -- Stash functionality (similar to shelf)
          vim.keymap.set("n", "<leader>gt", ":Git stash<CR>", 
            { buffer = bufnr, desc = "Stash changes (shelf)" })
          vim.keymap.set("n", "<leader>gp", ":Git stash pop<CR>", 
            { buffer = bufnr, desc = "Pop stashed changes" })
          vim.keymap.set("n", "<leader>gl", ":Git stash list<CR>", 
            { buffer = bufnr, desc = "List stashed changes" })
          
          -- Preview hunk
          vim.keymap.set("n", "<leader>gp", gs.preview_hunk, 
            { buffer = bufnr, desc = "Preview hunk" })
          
          -- Visual mode is especially useful for staging specific lines
          vim.keymap.set("v", "<leader>gs", function() 
            gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) 
          end, { buffer = bufnr, desc = "Stage selected lines" })
          
          vim.keymap.set("v", "<leader>gr", function() 
            gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) 
          end, { buffer = bufnr, desc = "Reset selected lines" })
          
          -- Select entire hunk in visual mode
          vim.keymap.set("n", "<leader>ghv", gs.select_hunk, 
            { buffer = bufnr, desc = "Select hunk" })
        end,
      })
    end,
  },
  
  -- Enhanced git commands
  {
    "tpope/vim-fugitive",
    config = function()
      -- Add stash-related commands for shelf-like functionality
      vim.keymap.set("n", "<leader>gts", ":Git stash save ", 
        { desc = "Stash (shelf) with message" })
      
      -- Additional git commands
      vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
      vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
    end,
  }
}