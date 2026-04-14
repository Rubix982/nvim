-- Extended linter configuration: Go (golangci-lint) + Markdown
return {
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = lint.linters_by_ft or {}

      -- Go: golangci-lint (runs gosec, govet, errcheck, gocritic, revive, etc.)
      lint.linters_by_ft['go'] = { 'golangcilint' }

      -- Markdown
      if vim.fn.executable('markdownlint') > 0 then
        lint.linters_by_ft['markdown'] = { 'markdownlint' }
      end

      -- Customize golangci-lint to use the nearest config file
      lint.linters.golangcilint = lint.linters.golangcilint or {}
      local gc = lint.linters.golangcilint
      gc.args = gc.args or {}
      -- Run from the directory containing go.mod
      gc.cwd = function()
        -- Find nearest go.mod directory
        local gomod = vim.fs.find('go.mod', {
          upward = true,
          path = vim.fn.expand '%:p:h',
        })
        if gomod and #gomod > 0 then
          return vim.fn.fnamemodify(gomod[1], ':h')
        end
        return vim.fn.getcwd()
      end
    end,
  },
}
