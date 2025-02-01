return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require('toggleterm').setup {
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          }
        }
      }
      local function get_executable_path()
        return vim.fn.expand('%:p:r') -- Gets current file path without extension
      end

      local function find_main_go()
        -- Check common locations for main.go
        local possible_paths = {
          vim.fn.getcwd() .. '/main.go',         -- Root directory
          vim.fn.getcwd() .. '/src/main.go',     -- src directory
          vim.fn.getcwd() .. '/cmd/main.go',     -- cmd directory
          vim.fn.getcwd() .. '/cmd/app/main.go', -- cmd/app directory
          vim.fn.getcwd() .. '/cmd/api/main.go', -- cmd/app directory
        }

        for _, path in ipairs(possible_paths) do
          if vim.fn.filereadable(path) == 1 then
            return vim.fn.fnamemodify(path, ':h') -- Return the directory containing main.go
          end
        end

        return nil
      end

      local function run_file()
        vim.cmd('write')
        local file = vim.fn.expand('%:p')
        local file_type = vim.fn.expand('%:e')

        if file_type == 'c' then
          local executable = vim.fn.expand('%:p:r')
          local compile_cmd = string.format('gcc -Wall -g %s -o %s', file, executable)
          local compile_result = vim.fn.system(compile_cmd)

          if vim.v.shell_error ~= 0 then
            vim.notify("Compilation failed: " .. compile_result, vim.log.levels.ERROR)
            return nil
          end
          return executable
        elseif file_type == 'go' then
          -- First try to find the module root
          local root_dir = vim.fn.systemlist('go env GOMOD')[1]
          if root_dir ~= '' then
            root_dir = vim.fn.fnamemodify(root_dir, ':h')
            -- Try to find main.go in common locations
            local main_dir = find_main_go()
            if main_dir then
              -- If main.go is found, run from its directory
              return string.format('cd %s && go run .', main_dir)
            else
              -- Fallback to module root if main.go isn't found in common locations
              return string.format('cd %s && go run .', root_dir)
            end
          else
            -- If not in a module, try to find main.go
            local main_dir = find_main_go()
            if main_dir then
              return string.format('cd %s && go run .', main_dir)
            else
              -- Last resort: run the current file
              return "go run " .. file
            end
          end
        end
      end

      -- Create commands for running executables
      vim.api.nvim_create_user_command('Run', function()
        local run_cmd = run_file()
        if run_cmd then
          vim.cmd('split')
          vim.cmd('terminal ' .. run_cmd)
          vim.cmd('startinsert')
        end
      end, {})

      vim.api.nvim_create_user_command('RunArgs', function()
        local run_cmd = run_file()
        if run_cmd then
          -- Prompt for arguments
          local args = vim.fn.input('Arguments: ')
          vim.cmd('split')
          vim.cmd('terminal ' .. run_cmd .. ' ' .. args)
          vim.cmd('startinsert')
        end
      end, {})

      vim.api.nvim_create_user_command('RunFloat', function()
        local run_cmd = run_file()
        if run_cmd then
          -- Create and run in floating terminal
          local Terminal = require('toggleterm.terminal').Terminal
          local float = Terminal:new({
            cmd = run_cmd,
            direction = 'float',
            float_opts = {
              border = 'double',
            },
            on_open = function(term)
              vim.cmd('startinsert!')
            end,
          })
          float:toggle()
        end
      end, {})


      -- Function to run Go tests
      local function run_go_test(args)
        local dir = vim.fn.expand('%:p:h')
        local cmd = "go test "
        if args then
          cmd = cmd .. args .. " "
        end
        cmd = cmd .. "./..."
        return cmd
      end

      -- New commands for Go tests
      vim.api.nvim_create_user_command('GoTest', function()
        local cmd = run_go_test()
        vim.cmd('split')
        vim.cmd('terminal ' .. cmd)
        vim.cmd('startinsert')
      end, {})

      vim.api.nvim_create_user_command('GoTestFloat', function()
        local cmd = run_go_test()
        local Terminal = require('toggleterm.terminal').Terminal
        local float = Terminal:new({
          cmd = cmd,
          direction = 'float',
          float_opts = {
            border = 'double',
          },
          on_open = function(term)
            vim.cmd('startinsert!')
          end,
        })
        float:toggle()
      end, {})

      vim.api.nvim_create_user_command('GoTestVerbose', function()
        local cmd = run_go_test("-v")
        vim.cmd('split')
        vim.cmd('terminal ' .. cmd)
        vim.cmd('startinsert')
      end, {})

      -- Add keymaps
      local wk = require("which-key")
      wk.add(
        {
          { "<leader>r",   group = "Run" },
          { "<leader>ra",  ":RunArgs<CR>",       desc = "Run with Arguments" },
          { "<leader>rf",  ":RunFloat<CR>",      desc = "Run in Floating Terminal" },
          { "<leader>rr",  ":Run<CR>",           desc = "Run in Split Terminal" },
          { "<leader>rgt", ":GoTest<CR>",        desc = "Run Go Tests" },
          { "<leader>rgf", ":GoTestFloat<CR>",   desc = "Run Go Tests in Float" },
          { "<leader>rgv", ":GoTestVerbose<CR>", desc = "Run Go Tests Verbose" },
          -- t = {
          --   name = "Test",
          --   t = { ":GoTest<CR>", "Run Go Tests" },
          --   f = { ":GoTestFloat<CR>", "Run Go Tests in Float" },
          --   v = { ":GoTestVerbose<CR>", "Run Go Tests Verbose" },
          -- },
        })
    end
  },
  {
  }
}
