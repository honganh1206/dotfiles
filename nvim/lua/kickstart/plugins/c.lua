return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      -- C specific run functions
      local function run_c_file()
        local file = vim.fn.expand('%:p')
        local executable = vim.fn.expand('%:p:r')
        local compile_cmd = string.format('gcc -Wall -g %s -o %s', file, executable)
        local compile_result = vim.fn.system(compile_cmd)

        if vim.v.shell_error ~= 0 then
          vim.notify("Compilation failed: " .. compile_result, vim.log.levels.ERROR)
          return nil
        end
        return executable
      end
      -- Create commands for running executables
      vim.api.nvim_create_user_command('CRun', function()
        local run_cmd = run_c_file()
        if run_cmd then
          vim.cmd('split')
          vim.cmd('terminal ' .. run_cmd)
          vim.cmd('startinsert')
        end
      end, {})

      -- Add keymaps
      local wk = require("which-key")
      wk.add(
        {
          { "<leader>rc",  group = "C Lang" },
          { "<leader>rcr", ":CRun<CR>",     desc = "Run C Program" },
        })
    end
  },
}
