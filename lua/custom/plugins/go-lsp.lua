-- Gopls setup via FileType autocmd (avoids conflicting lspconfig specs)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'gomod', 'gowork', 'gosum', 'gotmpl' },
  callback = function(ev)
    -- Only set up once
    if vim.g._gopls_setup_done then
      -- If already set up, just try to start the client for this buffer
      vim.lsp.buf_attach_client(ev.buf, vim.g._gopls_client_id or 0)
      return
    end
    vim.g._gopls_setup_done = true

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
    if ok_cmp then
      capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
    end

    require('lspconfig').gopls.setup {
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod', 'gowork', 'gosum', 'gotmpl' },
      root_dir = function(fname)
        local util = require 'lspconfig.util'
        -- Prioritize .git (repo root) over go.mod (module root)
        -- so gopls sees the whole monorepo, not just one module
        return util.root_pattern('.git')(fname)
            or util.root_pattern('go.work', 'go.mod')(fname)
      end,
      capabilities = capabilities,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
          gofumpt = true,
          completeFunctionCalls = true,
          usePlaceholders = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    }

    -- Trigger lspconfig to attach to the current buffer
    vim.cmd('LspStart gopls')
  end,
})

-- Rounded borders + padding on all LSP floating windows
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
  max_width = 80,
  pad_top = 1,
  pad_bottom = 1,
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
  max_width = 80,
  pad_top = 1,
  pad_bottom = 1,
})

-- Return empty table (lazy.nvim requires a return from plugin files)
return {}
