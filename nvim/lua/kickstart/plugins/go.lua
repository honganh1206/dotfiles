return {
  -- golang
  'ray-x/go.nvim',
  dependencies = { -- optional packages
    -- "ray-x/guihua.lua",
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('go').setup()
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

    -- Go specific run functions
    local function run_go_file()
      local file = vim.fn.expand('%:p')
      local root_dir = vim.fn.systemlist('go env GOMOD')[1]
      if root_dir ~= '' then
        root_dir = vim.fn.fnamemodify(root_dir, ':h')
        local main_dir = find_main_go()
        if main_dir then
          return string.format('cd %s && go run .', main_dir)
        else
          return string.format('cd %s && go run .', root_dir)
        end
      else
        local main_dir = find_main_go()
        if main_dir then
          return string.format('cd %s && go run .', main_dir)
        else
          return "go run " .. file
        end
      end
    end

    -- Go test functions
    local function run_go_test(args)
      local dir = vim.fn.expand('%:p:h')
      local cmd = "go test "
      if args then
        cmd = cmd .. args .. " "
      end
      cmd = cmd .. "./..."
      return cmd
    end

    -- Create Go specific commands
    vim.api.nvim_create_user_command('GoRun', function()
      local run_cmd = run_go_file()
      vim.cmd('split')
      vim.cmd('terminal ' .. run_cmd)
      vim.cmd('startinsert')
    end, {})

    -- New commands for Go tests
    vim.api.nvim_create_user_command('GoTest', function()
      local cmd = run_go_test()
      vim.cmd('split')
      vim.cmd('terminal ' .. cmd)
      vim.cmd('startinsert')
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
        { "<leader>rg",  group = "Golang" },
        { "<leader>rgr", ":GoRun<CR>",         desc = "Run Go Program" },
        { "<leader>rgt", ":GoTest<CR>",        desc = "Run Go Tests" },
        { "<leader>rgv", ":GoTestVerbose<CR>", desc = "Run Go Tests Verbose" },
      })
  end,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod', 'goimports', 'gofumpt' },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
