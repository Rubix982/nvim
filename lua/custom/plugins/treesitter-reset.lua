-- Plugin to help reset treesitter parsers
return {
  {
    dir = "~/.config/nvim/lua/custom/plugins/treesitter-reset",
    name = "treesitter-reset",
    config = function()
      vim.api.nvim_create_user_command("TreesitterReset", function()
        -- Create the command to reset treesitter
        local treesitter_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
        local parser_dir = vim.fn.stdpath("data") .. "/treesitter"
        
        vim.notify("Resetting treesitter parsers...", vim.log.levels.INFO)
        
        -- Clean up parser directories
        vim.fn.mkdir(vim.fn.stdpath("data") .. "/treesitter-backup", "p")
        
        -- Create a backup command
        local backup_cmd = "cp -r " .. parser_dir .. " " .. 
                          vim.fn.stdpath("data") .. "/treesitter-backup/treesitter-" .. 
                          os.date("%Y%m%d%H%M%S")
        
        -- Run the backup
        vim.fn.system(backup_cmd)
        
        -- Remove parsers that are causing issues
        vim.fn.system("rm -rf " .. parser_dir .. "/parser/query.so")
        vim.fn.system("rm -rf " .. parser_dir .. "/parser/typescript.so")
        vim.fn.system("rm -rf " .. parser_dir .. "/parser/dockerfile.so")
        
        -- Remove query files that are causing issues
        vim.fn.system("rm -rf " .. treesitter_dir .. "/queries/query")
        vim.fn.system("rm -rf " .. treesitter_dir .. "/queries/typescript")
        vim.fn.system("rm -rf " .. treesitter_dir .. "/queries/dockerfile")
        
        -- Update parser-info.json
        local parser_info_path = parser_dir .. "/parser-info.json"
        local parser_info = vim.fn.filereadable(parser_info_path) == 1 and
                            vim.fn.json_decode(vim.fn.readfile(parser_info_path)) or {}
        
        -- Remove problematic parsers from info
        if type(parser_info) == "table" then
          parser_info["query"] = nil
          parser_info["typescript"] = nil
          parser_info["dockerfile"] = nil
          
          vim.fn.writefile({vim.fn.json_encode(parser_info)}, parser_info_path)
        end
        
        vim.notify("Treesitter parsers have been reset. Restart Neovim now.", vim.log.levels.INFO)
      end, {})
    end
  }
}