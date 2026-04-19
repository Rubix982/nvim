-- UI overhaul: catppuccin + bufferline + lualine + indent guides + noice
return {
  -- ── Colorscheme: Catppuccin Mocha ──────────────────────────────
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    opts = {
      flavour = 'mocha',
      background = { light = 'latte', dark = 'mocha' },
      transparent_background = false,
      term_colors = true,
      dim_inactive = { enabled = true, percentage = 0.20 },
      styles = {
        comments = { 'italic' },
        keywords = { 'bold' },
        functions = { 'bold' },
        strings = {},
        variables = {},
      },
      custom_highlights = function(colors)
        return {
          -- Floating windows: high-contrast bg for hover, docs, signatures
          NormalFloat = { bg = colors.surface2, fg = colors.text },
          FloatBorder = { bg = colors.surface2, fg = colors.lavender },
          FloatTitle = { bg = colors.blue, fg = colors.mantle, bold = true },
          -- Completion menu
          Pmenu = { bg = colors.surface0, fg = colors.text },
          PmenuSel = { bg = colors.blue, fg = colors.mantle, bold = true },
          PmenuSbar = { bg = colors.surface1 },
          PmenuThumb = { bg = colors.lavender },
          CmpBorder = { fg = colors.surface2, bg = colors.surface0 },
          CmpSel = { bg = colors.blue, fg = colors.mantle, bold = true },
          -- Completion kind icons — each type gets its own color
          CmpItemKindFunction = { fg = colors.blue },
          CmpItemKindMethod = { fg = colors.blue },
          CmpItemKindVariable = { fg = colors.flamingo },
          CmpItemKindField = { fg = colors.flamingo },
          CmpItemKindProperty = { fg = colors.flamingo },
          CmpItemKindClass = { fg = colors.yellow },
          CmpItemKindInterface = { fg = colors.yellow },
          CmpItemKindStruct = { fg = colors.yellow },
          CmpItemKindModule = { fg = colors.peach },
          CmpItemKindKeyword = { fg = colors.mauve },
          CmpItemKindSnippet = { fg = colors.green },
          CmpItemKindText = { fg = colors.overlay2 },
          CmpItemKindConstant = { fg = colors.peach },
          CmpItemKindEnum = { fg = colors.yellow },
          CmpItemKindEnumMember = { fg = colors.teal },
          CmpItemKindValue = { fg = colors.peach },
          CmpItemKindFile = { fg = colors.blue },
          CmpItemKindFolder = { fg = colors.blue },
          CmpItemAbbrMatch = { fg = colors.blue, bold = true },
          CmpItemAbbrMatchFuzzy = { fg = colors.blue, bold = true },
          CmpItemAbbrDeprecated = { fg = colors.overlay0, strikethrough = true },
          CmpItemMenu = { fg = colors.overlay1, italic = true },
          -- LSP hover/signature (noice may use these)
          LspInfoBorder = { fg = colors.lavender, bg = colors.surface2 },
          DiagnosticFloatingError = { bg = colors.surface2, fg = colors.red },
          DiagnosticFloatingWarn = { bg = colors.surface2, fg = colors.yellow },
          DiagnosticFloatingInfo = { bg = colors.surface2, fg = colors.blue },
          DiagnosticFloatingHint = { bg = colors.surface2, fg = colors.teal },
          -- Noice floats
          NoiceCmdlinePopup = { bg = colors.surface2, fg = colors.text },
          NoiceCmdlinePopupBorder = { bg = colors.surface2, fg = colors.lavender },
          -- LSP hover markdown rendering — bright and readable
          ['@text.literal'] = { fg = colors.rosewater },
          ['@text.emphasis'] = { fg = colors.mauve, italic = true },
          ['@text.strong'] = { fg = colors.mauve, bold = true },
          ['@text.uri'] = { fg = colors.blue, underline = true },
          ['@parameter'] = { fg = colors.flamingo, bold = true },
          ['@type'] = { fg = colors.yellow, bold = true },
          ['@type.builtin'] = { fg = colors.yellow },
          ['@function'] = { fg = colors.blue, bold = true },
          ['@keyword'] = { fg = colors.mauve, bold = true },
          -- Markdown in floats
          markdownH1 = { fg = colors.red, bold = true },
          markdownH2 = { fg = colors.peach, bold = true },
          markdownH3 = { fg = colors.yellow, bold = true },
          markdownCode = { fg = colors.green, bg = colors.surface1 },
          markdownCodeBlock = { fg = colors.green },
          markdownBold = { fg = colors.text, bold = true },
          markdownItalic = { fg = colors.text, italic = true },
        }
      end,
      integrations = {
        cmp = true,
        dashboard = true,
        fidget = true,
        gitsigns = true,
        indent_blankline = { enabled = true, scope_color = 'lavender' },
        mason = true,
        neotree = true,
        noice = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
      },
    },
  },

  -- Disable the old tokyonight from loading
  {
    'folke/tokyonight.nvim',
    enabled = false,
  },

  -- ── Bufferline (buffer tabs) ───────────────────────────────────
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers',
          themable = true,
          numbers = 'ordinal',
          close_command = 'bdelete! %d',
          indicator = { style = 'icon', icon = ' ▎' },
          buffer_close_icon = '󰅙',
          modified_icon = '',
          close_icon = '󰅚',
          left_trunc_marker = '',
          right_trunc_marker = '',
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level)
            local icon = level:match('error') and ' ' or ' '
            return ' ' .. icon .. count
          end,
          separator_style = { '', '' },
          style_preset = require('bufferline').style_preset.no_italic,
          show_close_icon = false,
          show_buffer_close_icons = true,
          show_tab_indicators = true,
          always_show_bufferline = true,
          offsets = {
            {
              filetype = 'neo-tree',
              text = '  File Explorer',
              highlight = 'Directory',
              separator = true,
            },
          },
        },
      }
    end,
  },

  -- ── Lualine (status line) — bubble/pill style ───────────────────
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
    event = 'VeryLazy',
    config = function()
      -- Catppuccin mocha palette (hardcoded for reliability)
      local colors = {
        blue    = '#89b4fa',
        green   = '#a6e3a1',
        mauve   = '#cba6f7',
        red     = '#f38ba8',
        peach   = '#fab387',
        text    = '#cdd6f4',
        mantle  = '#181825',
        surface = '#313244',
        overlay = '#6c7086',
      }

      -- Key: section c has NO bg — it inherits statusline bg,
      -- which lets the  /  separators create visible pill edges
      local bubbles = {
        normal = {
          a = { fg = colors.mantle, bg = colors.blue, gui = 'bold' },
          b = { fg = colors.blue, bg = colors.surface },
          c = { fg = colors.text },
        },
        insert = {
          a = { fg = colors.mantle, bg = colors.green, gui = 'bold' },
          b = { fg = colors.green, bg = colors.surface },
        },
        visual = {
          a = { fg = colors.mantle, bg = colors.mauve, gui = 'bold' },
          b = { fg = colors.mauve, bg = colors.surface },
        },
        replace = {
          a = { fg = colors.mantle, bg = colors.red, gui = 'bold' },
          b = { fg = colors.red, bg = colors.surface },
        },
        command = {
          a = { fg = colors.mantle, bg = colors.peach, gui = 'bold' },
          b = { fg = colors.peach, bg = colors.surface },
        },
        inactive = {
          a = { fg = colors.overlay, bg = colors.surface },
          b = { fg = colors.overlay, bg = colors.surface },
          c = { fg = colors.overlay },
        },
      }

      -- Custom components for k8s and docker context
      local function k8s_context()
        local handle = io.popen('kubectl config current-context 2>/dev/null')
        if handle then
          local result = handle:read('*l')
          handle:close()
          if result and result ~= '' then
            return '󱃾 ' .. result
          end
        end
        return ''
      end

      -- Cache k8s context (expensive to shell out every render)
      local k8s_cache = { value = '', updated = 0 }
      local function k8s_cached()
        local now = os.time()
        if now - k8s_cache.updated > 30 then
          k8s_cache.value = k8s_context()
          k8s_cache.updated = now
        end
        return k8s_cache.value
      end

      local function lsp_name()
        local clients = vim.lsp.get_clients and vim.lsp.get_clients { bufnr = 0 }
            or vim.lsp.buf_get_clients(0)
        if #clients == 0 then return '' end
        local names = {}
        for _, c in ipairs(clients) do
          table.insert(names, c.name)
        end
        return ' ' .. table.concat(names, ', ')
      end

      local function docker_context()
        local handle = io.popen('docker context show 2>/dev/null')
        if handle then
          local result = handle:read('*l')
          handle:close()
          if result and result ~= '' then
            return ' ' .. result
          end
        end
        return ''
      end

      local docker_cache = { value = '', updated = 0 }
      local function docker_cached()
        local now = os.time()
        if now - docker_cache.updated > 30 then
          docker_cache.value = docker_context()
          docker_cache.updated = now
        end
        return docker_cache.value
      end

      local function go_version()
        if vim.bo.filetype ~= 'go' then return '' end
        return ' Go'
      end

      require('lualine').setup {
        options = {
          theme = bubbles,
          component_separators = '',
          section_separators = { left = '', right = '' },
          globalstatus = true,
          disabled_filetypes = {
            statusline = { 'dashboard', 'toggleterm' },
            winbar = { 'dashboard', 'neo-tree', 'toggleterm', 'DiffviewFiles', 'noice' },
          },
        },
        sections = {
          -- Left: mode pill → branch → diff
          lualine_a = {
            { 'mode', icon = '', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = {
            { 'branch', icon = '', separator = { left = '' } },
            { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } },
          },
          -- Center: file + diagnostics
          lualine_c = {
            { 'filetype', icon_only = true, padding = { left = 1, right = 0 } },
            { 'filename', path = 1, symbols = { modified = ' ●', readonly = ' 󰌾' } },
            {
              'diagnostics',
              sources = { 'nvim_lsp' },
              symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
              separator = '',
            },
          },
          -- Right: Copilot → LSP → Go → Docker → K8s → encoding → location
          lualine_x = {
            { 'copilot', show_colors = true, show_loading = true },
            { lsp_name, color = { fg = colors.green } },
            { go_version, color = { fg = colors.blue } },
            { docker_cached, color = { fg = colors.blue } },
            { k8s_cached, color = { fg = colors.mauve } },
          },
          lualine_y = {
            { 'encoding', separator = { left = '' } },
            'fileformat',
          },
          lualine_z = {
            { 'progress', separator = { left = '' } },
            { 'location', icon = '', separator = { right = '' }, left_padding = 2 },
          },
        },
        -- Winbar: per-window file indicator (not on terminal/neo-tree)
        winbar = {
          lualine_c = {
            { 'filetype', icon_only = true, padding = { left = 1, right = 0 } },
            {
              'filename',
              path = 1,
              symbols = { modified = ' ●', readonly = ' 󰌾' },
              color = { gui = 'bold' },
            },
          },
        },
        inactive_winbar = {
          lualine_c = {
            { 'filetype', icon_only = true, padding = { left = 1, right = 0 } },
            { 'filename', path = 1, color = { fg = colors.overlay } },
          },
        },
      }
    end,
  },

  -- ── Indent guides ──────────────────────────────────────────────
  {
    'lukas-reineke/indent-blankline.nvim',
    version = '3.*',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local rainbow = {
        RainbowRed = '#E06C75',
        RainbowYellow = '#E5C07B',
        RainbowBlue = '#61AFEF',
        RainbowOrange = '#D19A66',
        RainbowGreen = '#98C379',
        RainbowViolet = '#C678DD',
        RainbowCyan = '#56B6C2',
      }
      for name, color in pairs(rainbow) do
        vim.api.nvim_set_hl(0, name, { fg = color })
      end

      local ok, hooks = pcall(require, 'ibl.hooks')
      if ok then
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          for name, color in pairs(rainbow) do
            vim.api.nvim_set_hl(0, name, { fg = color })
          end
        end)
      end

      require('ibl').setup {
        indent = { char = '│', tab_char = '│' },
        scope = {
          show_start = true,
          show_end = false,
          highlight = {
            'RainbowRed', 'RainbowYellow', 'RainbowBlue',
            'RainbowOrange', 'RainbowGreen', 'RainbowViolet', 'RainbowCyan',
          },
        },
        exclude = {
          filetypes = {
            '', 'help', 'dashboard', 'neo-tree', 'Trouble',
            'lazy', 'mason', 'toggleterm', 'noice', 'notify',
          },
          buftypes = { 'terminal', 'nofile', 'quickfix', 'prompt' },
        },
      }
    end,
  },

  -- ── Noice: floating cmdline + notifications ────────────────────
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      cmdline = {
        enabled = true,
        view = 'cmdline_popup',
        format = {
          cmdline = { pattern = '^:', icon = ' ', lang = 'vim' },
          search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
          search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
          filter = { pattern = '^:%s*!', icon = ' $', lang = 'bash' },
          lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = ' ', lang = 'lua' },
        },
      },
      messages = { enabled = true, view_search = 'virtualtext' },
      popupmenu = { enabled = true, backend = 'nui' },
      notify = { enabled = true, view = 'notify' },
      lsp = {
        progress = { enabled = true },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
        -- Disable noice hover/signature — Warp terminal can't z-order
        -- these floats properly. Let Neovim's native LSP handle them.
        hover = { enabled = false },
        signature = { enabled = false },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },

  -- ── Which-key border ───────────────────────────────────────────
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      win = { border = 'rounded' },
    },
  },

  -- ── Dashboard ──────────────────────────────────────────────────
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('dashboard').setup {
        theme = 'doom',
        config = {
          header = {
            '',
            '',
            '                                                       ',
            ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
            ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
            ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
            ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
            ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
            ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
            '',
            '              Powered by lazy.nvim + catppuccin          ',
            '',
          },
          center = {
            { icon = '  ', desc = 'New File            ', action = 'enew', key = 'n' },
            { icon = '  ', desc = 'Find File           ', action = 'Telescope find_files', key = 'f' },
            { icon = '  ', desc = 'Recent Files        ', action = 'Telescope oldfiles', key = 'r' },
            { icon = '  ', desc = 'Find Word           ', action = 'Telescope live_grep', key = 'g' },
            { icon = '  ', desc = 'File Browser        ', action = 'Neotree toggle', key = 'e' },
            { icon = '  ', desc = 'Quit                ', action = 'qa', key = 'q' },
          },
          footer = {},
        },
      }
    end,
  },
}
