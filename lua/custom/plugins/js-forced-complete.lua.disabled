-- JavaScript forced completion without LSP
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Create a command to enable keyword-based completions for JavaScript files
      vim.api.nvim_create_user_command("JSFallbackComplete", function()
        -- Use keyword completion from various sources
        vim.bo.omnifunc = ""  -- Disable LSP omnifunc temporarily
        vim.bo.complete = ".,w,b,u,t,i"
        
        -- Define common JavaScript keywords for completion
        local js_keywords = {
          -- ES6+ keywords and built-ins
          "async", "await", "class", "const", "constructor", "export", "extends", "from", "function", 
          "import", "let", "new", "return", "static", "super", "this", "typeof", "var", "yield",
          
          -- Common built-in objects
          "Array", "Boolean", "Date", "Error", "Function", "JSON", "Map", "Math", "Number", 
          "Object", "Promise", "Proxy", "RegExp", "Set", "String", "Symbol", "WeakMap", "WeakSet",
          
          -- Common methods
          "addEventListener", "appendChild", "concat", "createElement", "filter", "find", "forEach", 
          "getElementById", "getElementsByClassName", "includes", "indexOf", "join", "length",
          "map", "match", "parse", "preventDefault", "push", "querySelector", "remove", "replace",
          "slice", "splice", "split", "stringify", "substring", "test", "then", "toString", "trim",
          
          -- Common Node.js built-ins
          "Buffer", "console", "exports", "fs", "global", "module", "path", "process", "require",
        }
        
        -- Create a temporary dictionary file with keywords
        local dict_path = vim.fn.tempname() .. "_js_dict.txt"
        local file = io.open(dict_path, "w")
        
        if file then
          for _, word in ipairs(js_keywords) do
            file:write(word .. "\n")
          end
          file:close()
          
          -- Set the dictionary for completion
          vim.opt_local.dictionary = dict_path
          
          -- Add dictionary to complete options
          vim.opt_local.complete:append("k")
          
          -- Create special mappings for this buffer
          vim.keymap.set('i', '<Tab>', function()
            local col = vim.fn.col('.') - 1
            if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
              return '<Tab>'
            else
              return '<C-n>'
            end
          end, { buffer = true, expr = true })
          
          print("JavaScript fallback completion enabled. Press <Tab> to complete.")
        else
          print("Failed to create dictionary file.")
        end
      end, {})
      
      -- Create a command to actually scan the current file for identifiers
      vim.api.nvim_create_user_command("JSScanCompletions", function()
        -- Collect all identifiers in current file for completion
        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local words = {}
        
        -- Extract all identifiers
        for _, line in ipairs(lines) do
          for word in line:gmatch("[a-zA-Z_][a-zA-Z0-9_%.]*") do
            words[word] = true
          end
        end
        
        -- Store the words in a temp dictionary file
        local dict_path = vim.fn.tempname() .. "_js_scan.txt"
        local file = io.open(dict_path, "w")
        
        if file then
          for word in pairs(words) do
            file:write(word .. "\n")
          end
          file:close()
          
          -- Add the dictionary
          local cur_dict = vim.opt_local.dictionary:get()
          if cur_dict ~= "" then
            vim.opt_local.dictionary = cur_dict .. "," .. dict_path
          else
            vim.opt_local.dictionary = dict_path
          end
          
          -- Ensure dictionary is used for completion
          vim.opt_local.complete:append("k")
          
          print("Scanned " .. vim.fn.len(words) .. " identifiers for completion")
        end
      end, {})
      
      -- Create a keybinding for these commands
      vim.keymap.set('n', '<leader>jf', ':JSFallbackComplete<CR>', { noremap = true, desc = "JS fallback completion" })
      vim.keymap.set('n', '<leader>js', ':JSScanCompletions<CR>', { noremap = true, desc = "JS scan file for completions" })
    end
  }
}