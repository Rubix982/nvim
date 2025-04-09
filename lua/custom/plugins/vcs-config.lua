-- Version Control System configuration
return {
  {
    "sindrets/diffview.nvim",
    opts = {
      use_icons = true,
      -- Disable Mercurial integration
      tools = {
        -- Disable hg (Mercurial)
        hg_cmd = false, -- Set to false to disable
      },
    },
  }
}