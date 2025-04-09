-- Debug and configuration for JavaScript/TypeScript LSP
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 1. First, check if the language server is available
      local has_typescript = vim.fn.executable('typescript-language-server') == 1
      
      -- 2. Create a JavaScript debug command
      vim.api.nvim_create_user_command("JSDebug", function()
        local lines = {}
        table.insert(lines, "JavaScript/TypeScript LSP Debug Information")
        table.insert(lines, "=======================================")
        table.insert(lines, "")
        
        -- Check TypeScript language server
        if has_typescript then
          table.insert(lines, "✓ typescript-language-server is available in PATH")
        else
          table.insert(lines, "✗ typescript-language-server is NOT available in PATH")
          table.insert(lines, "  → Run this command to install it: npm install -g typescript-language-server typescript")
        end
        
        -- Show active clients for current buffer
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        table.insert(lines, "")
        table.insert(lines, "Current buffer: " .. vim.api.nvim_buf_get_name(buf))
        table.insert(lines, "Filetype: " .. ft)
        table.insert(lines, "")
        
        -- List active LSP clients
        local clients = vim.lsp.get_active_clients({bufnr = buf})
        if #clients > 0 then
          table.insert(lines, "Active LSP clients for this buffer:")
          for _, client in ipairs(clients) do
            table.insert(lines, "  • " .. client.name .. " (id: " .. client.id .. ")")
            
            -- Check if intellisense capabilities are available
            if client.server_capabilities.completionProvider then
              table.insert(lines, "    ✓ Has completion capability")
            else
              table.insert(lines, "    ✗ NO completion capability")
            end
            
            if client.server_capabilities.hoverProvider then
              table.insert(lines, "    ✓ Has hover capability")
            else
              table.insert(lines, "    ✗ NO hover capability")
            end
          end
        else
          table.insert(lines, "✗ No active LSP clients for this buffer!")
          table.insert(lines, "")
          table.insert(lines, "Possible reasons:")
          table.insert(lines, "  1. The language server is not installed")
          table.insert(lines, "  2. The current file is not recognized as JavaScript/TypeScript")
          table.insert(lines, "  3. There might be LSP configuration errors")
        end
        
        -- Check nvim-cmp status
        local has_cmp = pcall(require, "cmp")
        if has_cmp then
          table.insert(lines, "")
          table.insert(lines, "✓ nvim-cmp is available")
        else
          table.insert(lines, "")
          table.insert(lines, "✗ nvim-cmp is NOT available")
        end
        
        -- Create a tsconfig.json file in the project root if it doesn't exist
        table.insert(lines, "")
        table.insert(lines, "Project Configuration:")
        
        local project_root = vim.fn.getcwd()
        local tsconfig_path = project_root .. "/tsconfig.json"
        local package_json_path = project_root .. "/package.json"
        
        if vim.fn.filereadable(tsconfig_path) == 1 then
          table.insert(lines, "✓ tsconfig.json exists")
        else
          table.insert(lines, "✗ No tsconfig.json found - TypeScript intellisense may be limited")
          table.insert(lines, "  → Create a basic tsconfig.json with: { \"compilerOptions\": { \"allowJs\": true } }")
        end
        
        if vim.fn.filereadable(package_json_path) == 1 then
          table.insert(lines, "✓ package.json exists")
        else
          table.insert(lines, "✗ No package.json found - This might affect module resolution")
        end
        
        -- Display the debug info
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        
        local width = 80
        local height = #lines
        vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          row = math.floor((vim.o.lines - height) / 2),
          col = math.floor((vim.o.columns - width) / 2),
          style = "minimal",
          border = "rounded",
        })
        
        -- Set buffer options
        vim.api.nvim_buf_set_option(buf, "modifiable", false)
        vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, noremap = true, silent = true })
      end, {})
      
      -- 3. Create a basic tsconfig.json in the project root if it doesn't exist
      vim.api.nvim_create_user_command("JSCreateConfig", function()
        local project_root = vim.fn.getcwd()
        local tsconfig_path = project_root .. "/tsconfig.json"
        
        if vim.fn.filereadable(tsconfig_path) == 0 then
          local tsconfig = [[
{
  "compilerOptions": {
    "target": "es2020",
    "module": "esnext",
    "moduleResolution": "node",
    "esModuleInterop": true,
    "allowJs": true,
    "checkJs": true,
    "resolveJsonModule": true,
    "strict": false,
    "skipLibCheck": true,
    "baseUrl": ".",
    "paths": {
      "*": ["*", "node_modules/*"]
    }
  },
  "include": ["**/*.js", "**/*.jsx", "**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules", "dist"]
}]]
          
          local file = io.open(tsconfig_path, "w")
          if file then
            file:write(tsconfig)
            file:close()
            print("Created tsconfig.json in " .. project_root)
          else
            print("Failed to create tsconfig.json")
          end
        else
          print("tsconfig.json already exists")
        end
        
        -- Create jsconfig.json if needed for pure JavaScript projects
        local jsconfig_path = project_root .. "/jsconfig.json"
        if vim.fn.filereadable(jsconfig_path) == 0 and vim.fn.filereadable(tsconfig_path) == 0 then
          local jsconfig = [[
{
  "compilerOptions": {
    "target": "es2020",
    "module": "esnext",
    "moduleResolution": "node",
    "checkJs": true,
    "allowJs": true,
    "resolveJsonModule": true,
    "baseUrl": ".",
    "paths": {
      "*": ["*", "node_modules/*"]
    }
  },
  "include": ["**/*.js", "**/*.jsx"],
  "exclude": ["node_modules", "dist"]
}]]
          
          local file = io.open(jsconfig_path, "w")
          if file then
            file:write(jsconfig)
            file:close()
            print("Created jsconfig.json in " .. project_root)
          else
            print("Failed to create jsconfig.json")
          end
        end
      end, {})
      
      -- Add keymaps for JavaScript debugging commands
      vim.keymap.set('n', '<leader>jD', '<cmd>JSDebug<CR>', { desc = 'JS: Debug Info' })
      vim.keymap.set('n', '<leader>jc', '<cmd>JSCreateConfig<CR>', { desc = 'JS: Create Config' })
      vim.keymap.set('n', '<leader>jA', '<cmd>JSForceAttach<CR>', { desc = 'JS: Force Attach LSP' })
      
      -- 4. Also create a command to force-attach the TypeScript server to current buffer
      vim.api.nvim_create_user_command("JSForceAttach", function()
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        
        if ft ~= "javascript" and ft ~= "typescript" and ft ~= "javascriptreact" and ft ~= "typescriptreact" then
          print("Current buffer is not a JavaScript/TypeScript file")
          return
        end
        
        -- Force attach the TypeScript language server
        vim.cmd("LspStart typescript")
        
        -- Check if it worked
        vim.defer_fn(function()
          local clients = vim.lsp.get_active_clients({bufnr = buf})
          local found = false
          for _, client in ipairs(clients) do
            if client.name == "typescript" then
              found = true
              break
            end
          end
          
          if found then
            print("TypeScript language server attached successfully")
          else
            print("Failed to attach TypeScript language server")
          end
        end, 1000)
      end, {})
    end
  }
}