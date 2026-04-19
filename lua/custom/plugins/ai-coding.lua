-- AI-assisted coding: Copilot (inline) + Avante (Claude sidebar)
return {
  -- ── GitHub Copilot: inline ghost text ──────────────────────────
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<M-l>',         -- Alt-l to accept
            accept_word = '<M-k>',    -- Alt-k to accept one word
            accept_line = '<M-j>',    -- Alt-j to accept one line
            next = '<M-]>',           -- Alt-] next suggestion
            prev = '<M-[>',           -- Alt-[ prev suggestion
            dismiss = '<C-]>',        -- Ctrl-] dismiss
          },
        },
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            open = '<M-CR>',
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = false,
          ['.'] = false,
        },
      }
    end,
  },

  -- Copilot status in lualine (shows icon when active)
  {
    'AndreM222/copilot-lualine',
    dependencies = { 'zbirenbaum/copilot.lua' },
  },

  -- ── Avante: Cursor-like AI sidebar (Claude) ────────────────────
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,
    -- Prebuilt binaries are in build/ — no compilation needed
    build = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      provider = 'claude',
      auto_suggestions_provider = 'copilot',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
          extra_request_body = {
            max_tokens = 4096,
          },
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
      },
      windows = {
        position = 'right',
        width = 40,
        sidebar_header = {
          align = 'center',
          rounded = true,
        },
      },
      hints = { enabled = true },
    },
  },
}
